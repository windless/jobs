# encoding: utf-8

require 'spec_helper'

describe "SignupPages" do
  subject { page }
  before { visit signup_path }

  it { should have_selector('title', text: '注册') }

  describe "with invalid information" do
    let(:submit) { "提交注册信息" }

    it "does not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end

    it "has error explanation" do
      click_button submit
      page.should have_selector('div.alert.alert-block.alert-error')
    end
  end
end
