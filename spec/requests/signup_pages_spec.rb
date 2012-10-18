# encoding: utf-8

require 'spec_helper'

describe "SignupPages" do
  subject { page }
  before { visit signup_path }

  it { should have_selector('title', text: '注册') }
end
