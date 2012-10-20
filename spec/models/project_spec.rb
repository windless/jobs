# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

require 'spec_helper'

describe Project do
  before { @project = Project.new(name: "Project", description: "Des") }
  subject { @project }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:creator) }
  it { should respond_to(:created_at) }
  it { should respond_to(:sprints) }
  it { should respond_to(:user_id) }
  it { should respond_to(:current_sprint) }

  context "when name is not present" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @project.name = "a" * 256 }
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @project.description = "a" * 256 }
    it { should_not be_valid }
  end

  describe "current_sprint" do
    before { @project.save! }
    let!(:older_sprint) { FactoryGirl.create :sprint, project: @project, created_at: 1.day.ago }
    let!(:newer_sprint) { FactoryGirl.create :sprint, project: @project, created_at: 1.hour.ago }

    its(:current_sprint) { should == newer_sprint }
  end
end

