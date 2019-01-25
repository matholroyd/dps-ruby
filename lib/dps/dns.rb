require 'dnsruby'

module DPS
  class DNS
    
    class << self
      def get_records(domain)
        get_txt_records(domain).
        collect { |value| decode_txt_record(value) }.select(&:valid?)
      end
      
      def decode_txt_record(value)
        parts = value.gsub('"', '').split
        
        # Reverse since Ruby #pop starts from end of list.
        parts.reverse!
        action = parts.pop
        parts.reverse!

        case action
        when "dps:endpoint"  
          Endpoint.new(parts)
        else
          InvalidRecord.new("Unexpected action '#{action}'")
        end
      end
      
      def get_endpoint(domain)
        records = get_records(domain).select { |r| r.is_a?(Endpoint) }
        
        if records.length > 1
          TooManyRecords.new("Too many valid endpoint TXT records returned.")
        elsif records.length == 0
          NoRecords.new("No valid endpoint TXT records found.")
        else
          records[0]
        end
      end
      
      private 
      
      def get_txt_records(domain)
        result = []
        
        ::Dnsruby::DNS.open do |dns|
          begin
            record = dns.getresource(domain, "TXT")
            result << record.data
          rescue Dnsruby::NXDomain => e
            raise InvalidRecord.new("Invalid domain.")
          end
        end
        
        result
      end
    end
    
    class NoRecords < StandardError; end
    class TooManyRecords < StandardError; end
    class InvalidRecord < StandardError
      def valid?
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