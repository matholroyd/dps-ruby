require 'dnsruby'

module DPS
  class DNS
    
    class InvalidRecord; end
    class NoRecord; end
    class TooManyRecords; end
    
    class << self
      def get_records(domain)
        get_dns_txt_records.select { |record| valid_record?(record) }
      end
      
      def valid_record?(record)
        type, data = decode_txt_record(record)

        case type
        when :endpoint
           extract_endpoint(data) != InvalidRecord
        else
          false
        end
      end
      
      def get_endpoint(domain)
        records = get_records(domain)
        
        endpoint_records = records.select do |r| 
          type, data = decode_txt_record(r)
          type = :endpoint
        end
        
        if endpoint_records.length > 0
          TooManyRecords
        elsif endpoint_records.length == 0
          NoRecord
        else
          extract_endpoint(data)
        end
      end
      
      private 

      def decode_txt_record(record)
        record = record.gsub('"', '')
        parts = record.split
        
        # Reverse since Ruby #pop starts from end of list.
        parts.reverse!

        case parts.pop
        when "dps:endpoint"  
          [:endpoint, parts]
        else
          InvalidRecord
        end
      end

      def extract_endpoint(parts)
        url_part = parts.find { |d| d =~ /^url=/ } 
        
        if url_part.nil?
          InvalidRecord
        else
          begin
            url = URI(url_part.sub(/^url=/, ''))

            if !url.query.nil?
              InvalidRecord
            elsif !url.fragment.nil?
              InvalidRecord
            elsif url.port != 443
              InvalidRecord
            else
              url.to_s
            end
          rescue URI::InvalidURIError
            InvalidURIError
          end
        end
      end
      
      def get_dns_txt_records(domain)
        result = []
        
        ::Dnsruby::DNS.open do |dns|
          record = dns.getresource(domain, "TXT")
          result << record.data
        end
        
        result
      end
    end
    
  end
end