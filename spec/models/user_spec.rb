# encoding: utf-8

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: '张三',
                     email: 'zhangsan@email.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  subject { @user }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 256 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email is already taken" do
    before do
      same_email_user = @user.dup
      same_email_user.email = @user.email.upcase
      same_email_user.save!
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "when confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when confirmation is not match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when email format is not valid" do
    it "is not valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |email|
        @user.email = email
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "is valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |email|
        @user.email = email
        @user.should be_valid
      end
    end
  end

  describe "when password is too short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save! }

    context "with valid password" do
      let(:user) { User.find_by_email(@user.email) }
      it { should == user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user) { @user.authenticate('invalid') }
      it { should_not == user }
      specify { user.should be_false }
    end
  end
end
