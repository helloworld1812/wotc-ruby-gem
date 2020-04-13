require File.expand_path('../spec_helper', __FILE__)

describe WOTC do
  after do
    WOTC.reset
  end

  context 'when delegating to a client' do
    before do
      response = {
          headers: {
              content_type: "application/json; charset=utf-8"
          },
          body: fixture("user.json")
      }
      stub_get("user").to_return(response)
    end

    it "should return same result" do
      WOTC.access_token = "token"
      WOTC.current_user() == WOTC::Client.new(access_token: "token").current_user()
    end
  end

  describe ".client" do
    it "should be a WOTC::Client" do
      expect(WOTC.client).to be_a(WOTC::Client)
    end
  end

  describe ".access_token" do
    it "should be nil by default" do
      expect(WOTC.access_token).to eq(nil)
    end
  end

  describe ".endpoint" do
    it "should be https://sandbox.wotc.com/portal/api/v1/" do
      expect(WOTC.endpoint).to eq("https://sandbox.wotc.com/portal/api/v1/")
    end
  end

  describe ".auto_paginate" do
    it "should enable auto_paginate by default" do
      expect(WOTC.auto_paginate).to eq(true)
    end
  end

  describe ".per_page" do
    it "should be 20 by default" do
      expect(WOTC.per_page).to eq(20)
    end
  end

  describe ".format" do
    it "should be json" do
      expect(WOTC.format).to eq(:json)
    end
  end
end