# encoding: utf-8

require 'spec_helper'

describe "HomePages" do
  subject { page }

  before { visit root_path }

  it { should have_selector('title', text: '主页') }
  it { should have_selector('#logo', text: 'Jobs') }
  it { should have_link('主页', href: root_path) }

  describe "for non-signin-in user" do
    it { should have_selector('h1', text: '欢迎') }
    it { should have_link('注册', href: signup_path) }
    it { should have_link('登录', href: signin_path) }
    it { should_not have_link('Projects', href: projects_path) }
  end

  describe "for signin-user" do
    let(:user) { FactoryGirl.create :user }
    before do
      sign_in user
    end

    it { should have_content(user.name) }
    it { should_not have_link('注册', href: signup_path) }
    it { should_not have_link('登录', href: signin_path) }
    it { should have_link('退出', href: signout_path) }
    it { should have_link('Projects', href: projects_path) }

  end

  describe "sign_in method" do
    let(:user) { FactoryGirl.create :user }
    before do 
      visit signup_path
      sign_in user
    end

    it { should have_selector('title', text: '主页') }
  end
end
