require File.expand_path('../../../spec_helper', __FILE__)

describe WOTC::Client do
  describe '#get_company_settings' do
    it 'should get setting' do
      stub_get('company/settings').to_return(:body => fixture('company_setting.json'), :headers => {:content_type => "application/json; charset=utf-8"})
      settings = WOTC::Client.new.get_company_settings.body
      expect(settings['form_bg_color']).to eq('#FFFFFF')
      expect(settings['mask_ssn']).to eq('0')
    end
  end
  
  describe '#current_company' do
    it 'should return the current company' do
      stub_get('user').to_return(:body => fixture('user.json'), :headers => {:content_type => "application/json; charset=utf-8"})
      company = WOTC::Client.new.current_company
      expect(company['id']).to eq(519)
    end
  end
end

