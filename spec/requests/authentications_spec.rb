# encoding: utf-8

require 'spec_helper'

describe "Authentications" do
  subject { page }

  describe "projects page" do
    before { get projects_path }
    specify { response.should redirect_to(signin_path) }
    specify { flash[:notice].should_not be_nil }
  end

  describe "new project page" do
    before { get new_project_path }
    specify { response.should redirect_to(signin_path) }
    specify { flash[:notice].should_not be_nil }
  end

  describe "create project" do
    before { post projects_path }
    specify { response.should redirect_to(signin_path) }
    specify { flash[:notice].should_not be_nil }
  end
end
