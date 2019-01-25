require "spec_helper"

RSpec.describe DPS::DNS do

  subject { DPS::DNS }

  describe 'get_records' do
    let(:domain) { double }
    let(:valid_value) { double }
    let(:invalid_value) { double }
    let(:valid_record) { double(DPS::DNS::Endpoint, valid?: true) }
    let(:invalid_record) { double(DPS::DNS::Endpoint, valid?: false) }

    before :each do
      allow(subject).to receive(:decode_txt_record).with(valid_value).and_return(valid_record)
      allow(subject).to receive(:decode_txt_record).with(invalid_value).and_return(invalid_record)
    end

    it "should return valid dps TXT records for the domain" do
      allow(subject).to receive(:get_txt_records).with(domain).and_return(
        [valid_value, invalid_value]
      )
      
      expect(subject.get_records(domain)).to eq([valid_record])
    end
  end
  
  describe "decode_txt_record" do
    let(:endpoint) { double(DPS::DNS::Endpoint) }
    
    it "should return Endpoint when matches" do
      expect(DPS::DNS::Endpoint).to receive(:new).with(['A', 'B']).and_return(endpoint)
      
      expect(subject.decode_txt_record('"dps:endpoint A B"')).to eq(endpoint)
    end
    
    it "should return error if no match" do
      expect(subject.decode_txt_record('"dps:INCORRECT"')).to eq(DPS::DNS::InvalidRecord.new("Unexpected action 'dps:INCORRECT'"))
    end
  end

  describe "get_endpoint" do
    let(:url) { double }
    let(:domain) { double }
    let(:endpoint) { DPS::DNS::Endpoint.new }
    
    it "should return the url" do
      allow(subject).to receive(:get_records).and_return([endpoint])
      
      expect(subject.get_endpoint(domain)).to eq(endpoint)
    end

    it "should return error if more than 1 endpoint" do
      allow(subject).to receive(:get_records).and_return([endpoint, endpoint])
      
      expect(subject.get_endpoint(domain)).to eq(DPS::DNS::TooManyRecords.new)
    end

    it "should return error if no record" do
      allow(subject).to receive(:get_records).and_return([])
      
      expect(subject.get_endpoint(domain)).to eq(DPS::DNS::NoRecords.new)
    end
  end
  
  context DPS::DNS::Endpoint do
    describe "valid?" do
      it 'should allow simple url' do
        expect(DPS::DNS::Endpoint.new(['url=https://dps.example.com'])).to be_valid
      end

      it 'should allow url with path' do
        expect(DPS::DNS::Endpoint.new(['url=https://example.com/dps'])).to be_valid
      end

      it 'should not allow params in urls' do
        expect(DPS::DNS::Endpoint.new(['url=https://example.com?some=param'])).to_not be_valid
      end

      it 'should not allow fragments in urls' do
        expect(DPS::DNS::Endpoint.new(['url=https://example.com#fragment'])).to_not be_valid
      end

      it 'should require HTTPS' do
        expect(DPS::DNS::Endpoint.new(['url=http://example.com/dps'])).to_not be_valid
      end

      it "should include 'url=' part" do
        expect(DPS::DNS::Endpoint.new(['https://example.com/dps'])).to_not be_valid
      end
    end
    
  end
  
end
