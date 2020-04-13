require File.expand_path('../../spec_helper', __FILE__)

describe WOTC::Request do
  context 'HTTP Verb' do
    before do
      @object = Object.new
      @object.extend(WOTC::Request)
      allow(@object).to receive(:request).and_return("success")
    end

    it ".get" do
      expect(@object.get("employees")).to eq("success")
    end

    it ".post" do
      expect(@object.post("employees", {first_name: "Ryan", last_name: "Lv"})).to eq("success")
    end

    it ".put" do
      expect(@object.put("employees/3021", {first_name: "Ryan"})).to eq("success")
    end

    it ".delete" do
      expect(@object.delete("employees/3021", {first_name: "Ryan"})).to eq("success")
    end
  end

  describe ".request" do
    it "should return current user" do
      response = {
          headers: {
              content_type: "application/json; charset=utf-8"
          },
          body: fixture("user.json")
      }
      stub_get("user").to_return(response)
      result = WOTC::Client.new(access_token: "token").send(:get, WOTC::Configuration::DEFAULT_ENDPOINT + "user")
      expect(result["id"]).to eq(516)
    end
  end

  # describe ".paginate" do
  #   it "should return all employees" do
  #     page1 = {
  #         headers: {
  #             content_type: "application/json; charset=utf-8"
  #         },
  #         body: fixture("employees/page1.json")
  #     }
  #
  #     page1 = {
  #         headers: {
  #             content_type: "application/json; charset=utf-8"
  #         },
  #         body: fixture("employees/page1.json")
  #     }
  #   end
  # end
end