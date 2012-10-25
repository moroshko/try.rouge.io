require 'spec_helper'

describe ShellController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'execute'" do
    it "returns http success" do
      post 'execute', {:command => "(do (puts 42) 'quux)"}
      response.should be_success
      result = JSON[response.body]
      result.should eq(
        {"ok" => true,
         "stdout" => "42\n",
         "result" => "quux"})
    end
  end
end
