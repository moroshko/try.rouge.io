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
      post 'execute'
      response.should be_success
    end
  end
end
