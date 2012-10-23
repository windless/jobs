require 'spec_helper'

describe Work do
  let(:sprint) { FactoryGirl.create(:sprint) }
  before { @work = sprint.works.new(name: "work", description: "des ...") }
  subject { @work }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:sprint_id) }
  it { should respond_to(:sprint) }
  it { should respond_to(:state) }
  it { should respond_to(:checker) }
  it { should respond_to(:check_out_by!) }
  it { should respond_to(:checker_id) }
  it { should respond_to(:finish!) }

  describe "after saving" do
    before { @work.save! }
    its(:state) { should == "uncheck" }
  end

  describe "checked out by user" do
    let(:user) { FactoryGirl.create :user }
    before do
      @work.check_out_by!(user)
      @work.reload
    end

    its(:state) { should == "started" }
    its(:checker) { should == user }
  end

  describe "review by user" do
    let(:user) { FactoryGirl.create :user }
    before do
      @work.check_out_by!(user)
      @work.review!
      @work.reload
    end

    its(:state) { should == "review" }
  end

  describe "finish by user" do
    let(:user) { FactoryGirl.create :user }
    before do
      @work.check_out_by!(user)
      @work.finish!
      @work.reload
    end

    its(:state) { should == "complete" }
  end
end

