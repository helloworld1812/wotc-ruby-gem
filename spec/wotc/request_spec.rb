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

  describe "#request" do
    it "should return current user" do
      response = { headers: { content_type: "application/json; charset=utf-8" }, body: fixture("user.json") }
      stub_get("user").to_return(response)
      result = WOTC::Client.new.send(:get, WOTC::Configuration::DEFAULT_ENDPOINT + "user").body
      expect(result["id"]).to eq(516)
    end
  end

  describe "#paginate" do
    it "should return all employees" do
      first_page = { headers: { content_type: "application/json; charset=utf-8" }, body: fixture("employees/page1.json") }
      second_page = { headers: { content_type: "application/json; charset=utf-8" }, body: fixture("employees/page2.json") }

      stub_get("employees?per_page=20&page=1").to_return(first_page)
      stub_get("employees?per_page=20&page=2").to_return(second_page)
      result = WOTC::Client.new.send(:paginate, 'employees')
      expect(result.count).to eq(40)
    end
  end
end