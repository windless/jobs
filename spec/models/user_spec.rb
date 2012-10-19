# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#


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
  it { should respond_to(:remember_token) }
  it { should respond_to(:projects) }

  describe "remember token" do
    before { @user.save! }
    its(:remember_token) { should_not be_blank }
  end

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

  describe "project associations" do
    before { @user.save! }
    let!(:project1) { FactoryGirl.create(:project, user: @user, created_at: 1.day.ago) }
    let!(:project2) { FactoryGirl.create(:project, user: @user, created_at: 1.hour.ago) }

    it "has right projects in right order" do
      @user.projects.should == [project2, project1]
    end

    specify { project1.creator.should == @user }

  end
end
