require "spec_helper"

RSpec.describe DPS::DNS do

  subject { DPS::DNS }

  describe 'get_records' do
    let(:domain) { double }
    let(:valid_record) { double }
    let(:invalid_record) { double }

    before :each do
      allow(subject).to receive(:valid_record?).with(invalid_record).and_return(false)
      allow(subject).to receive(:valid_record?).with(valid_record  ).and_return(true)
    end
    
    it "should return valid dps TXT records for the domain" do
      allow(subject).to receive(:get_dns_txt_records).and_return(
        [invalid_record, valid_record]
      )

      expect(subject.get_records(domain)).to eq([valid_record])
    end
  end
  
  describe "valid_record?" do
    it 'should allow simple url' do
      expect(subject.valid_record?('"dps:endpoint url=https://dps.example.com"')).to be true
    end

    it 'should allow url with path' do
      expect(subject.valid_record?('"dps:endpoint url=https://example.com/dps"')).to be true
    end

    it 'should not allow params in urls' do
      expect(subject.valid_record?('"dps:endpoint url=https://example.com?some=param"')).to be false
    end

    it 'should require HTTPS' do
      expect(subject.valid_record?('"dps:endpoint url=http://example.com/dps"')).to be false
    end

    it "should include 'url=' part" do
      expect(subject.valid_record?('"dps:endpoint https://example.com/dps"')).to be false
    end
  
    it do
      expect(subject.valid_record?('"v=spf"')).to be false
    end
  end
  
  describe "get_endpoint" do
    it "should return the endpoint"
    
    it "should return error if more than 1 endpoint"
    
    it "should return error if no record"
  end
  
end
