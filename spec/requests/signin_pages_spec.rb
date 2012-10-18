# encoding: utf-8

require 'spec_helper'

describe "SigninPages" do
  subject { page }
  before { visit signin_path }

  it { should have_selector('title', text: '登录') }
end
