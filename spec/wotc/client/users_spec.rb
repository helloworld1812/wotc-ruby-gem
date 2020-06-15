require File.expand_path('../../../spec_helper', __FILE__)

describe WOTC::Client do
  describe '#current_user' do
    it 'should return true' do
      stub_get('user').to_return(:body => fixture('user.json'), :headers => {:content_type => "application/json; charset=utf-8"})
      user = WOTC::Client.new.current_user.body
      expect(user['id']).to eq(516)
    end
  end
end