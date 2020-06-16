require File.expand_path('../../../spec_helper', __FILE__)

describe WOTC::Client do
  describe '#token_valid?' do
    it 'should return true' do
      stub_get('user').to_return(:body => fixture('user.json'), :headers => {:content_type => "application/json; charset=utf-8"})
      expect(WOTC::Client.new.token_valid?).to be true
    end
  end
  
  describe '#wotc_calculator' do
    it 'should get true' do
      options = {
        "is_under_40": 'true',
        "has_snap": 'true',
        "has_ssi": 'true',
        "is_veteran": 'true',
        "is_felon": 'true',
        "is_unemployed": 'true'
      }
      
      stub_post('wotc/calculator').to_return(:body => 'true', :headers => {:content_type => "application/json; charset=utf-8"})
      expect(WOTC::Client.new.wotc_calculator(options)).to be true
    end
    
    it 'should get false' do
      options = {
        "is_under_40": 'false',
        "has_snap": 'false',
        "has_ssi": 'false',
        "is_veteran": 'false',
        "is_felon": 'false',
        "is_unemployed": 'false'
      }
      
      stub_post('wotc/calculator').to_return(:body => 'false', :headers => {:content_type => "application/json; charset=utf-8"})
      expect(WOTC::Client.new.wotc_calculator(options)).to be false
    end
  end
end