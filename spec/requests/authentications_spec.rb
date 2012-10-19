# encoding: utf-8

require 'spec_helper'

describe "Authentications" do
  subject { page }

  describe "projects page" do
    before { get projects_path }
    it "redirects to signin_path" do
      response.should redirect_to(signin_path)
    end
  end
end
