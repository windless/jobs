# encoding: utf-8

require 'spec_helper'

describe "SigninPages" do
  let(:user) { FactoryGirl.create :user }
  let(:submit) { "登录" }
  subject { page }
  before { visit signin_path }

  it { should have_selector('title', text: '登录') }

  describe "with invalid information" do
    before { click_button submit }
    it { should have_selector('div.alert.alert-error') }
  end
end
