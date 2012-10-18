# encoding: utf-8

require 'spec_helper'

describe "SignupPages" do
  let(:submit) { "提交注册信息" }
  subject { page }
  before { visit signup_path }

  it { should have_selector('title', text: '注册') }

  describe "with invalid information" do
    it "does not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end

    it "has error explanation" do
      click_button submit
      page.should have_selector('div.alert.alert-block.alert-error')
    end
  end

  describe "with valid information" do
    before do
      fill_in '姓名', with: '张三'
      fill_in 'Email', with: 'zhangsan@email.com'
      fill_in '密码', with: 'foobar'
      fill_in '确认密码', with: 'foobar'
    end

    it "creates a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    it "redirects to home page" do
      click_button submit
      page.should have_selector('title', text: '主页')
    end
  end
end
