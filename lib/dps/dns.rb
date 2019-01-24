require 'dnsruby'

module DPS
  class DNS
    
    class NoRecords; end
    class TooManyRecords; end
    
    class << self
      def get_records(domain)
        get_dns_txt_records(domain).
        collect { |value| decode_txt_record(value) }.select(&:valid?)
      end
      
      def decode_txt_record(value)
        parts = value.gsub('"', '').split
        
        # Reverse since Ruby #pop starts from end of list.
        parts.reverse!

        case parts.pop
        when "dps:endpoint"  
          Endpoint.new(parts)
        else
          InvalidRecord
        end
      end
      
      def get_endpoint(domain)
        records = get_records(domain).select { |r| r.is_a?(Endpoint) }
        
        if records.length > 1
          TooManyRecords
        elsif records.length == 0
          NoRecords
        else
          records[0]
        end
      end
      
      private 
      
      def get_dns_txt_records(domain)
        result = []
        
        ::Dnsruby::DNS.open do |dns|
          record = dns.getresource(domain, "TXT")
          result << record.data
        end
        
        result
      end
    end
    
    class InvalidRecord
      def self.valid?
        false
      end
    end
    
    class Endpoint < Struct.new(:data)
      def valid?
        uri &&
        uri.query.nil? &&
        uri.fragment.nil? &&
        uri.port == 443
      end
      
      def uri
        @uri ||= 
          begin
            URI(get_url_part.sub(/^url=/, ''))
          rescue 
            nil
          end
      end
      
      def url
        uri && uri.to_s
      end
      
      def get_url_part
        data.find { |d| d =~ /^url=/ } 
      end
    end
    
  end
end