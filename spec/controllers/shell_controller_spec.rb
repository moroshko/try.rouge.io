require 'spec_helper'

describe ShellController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'execute'" do
    it "returns http success" do
      get 'execute'
      response.should be_success
    end
  end
end
