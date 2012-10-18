# encoding: utf-8

require 'spec_helper'

describe "HomePages" do
  subject { page }

  before { visit root_path }

  it { should have_selector('title', text: '主页') }
  it { should have_selector('h1', text: '欢迎') }
  it { should have_selector('#logo', text: 'Jobs') }
  it { should have_link('主页', href: root_path) }
  it { should have_link('注册') }
  it { should have_link('登录') }
end
