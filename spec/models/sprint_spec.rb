# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Sprint do
  let(:project) { FactoryGirl.create :project }
  before do
    project.sprints.create!()
    @sprint = project.sprints.new(description: "des ...")
  end

  subject { @sprint }

  it { should respond_to(:project_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:prepare_name) }
  it { should respond_to(:works) }
  it { should respond_to(:uncheck_works) }
  it { should respond_to(:checked_out_works) }

  its(:prepare_name) { should == "sprint 2" }

  context "after saving" do
    before do
      @sprint.save!
    end

    its(:name) { should == "sprint 2" }
  end

  describe "work associations" do
    let(:worker) { FactoryGirl.create(:user) }

    describe "uncheck works" do
      let(:uncheck_work) { FactoryGirl.create(:work, sprint: @sprint) }
      its(:uncheck_works) { should include(uncheck_work) }
    end

    describe "checked_out works" do
      let(:checked_out_work) { FactoryGirl.create(:work, sprint: @sprint) }
      before do
        checked_out_work.check_out_by!(worker)
      end

      its(:checked_out_works) { should include(checked_out_work) }
      its(:uncheck_works) { should_not include(checked_out_work) }
    end

    describe "review works" do
      let(:review_work) { FactoryGirl.create(:work, sprint: @sprint) }
      before do
        review_work.check_out_by!(worker)
        review_work.finish!
      end

      its(:review_works) { should include(review_work) }
    end

    describe "complete works" do
      let(:complete_work) { FactoryGirl.create :work, sprint: @sprint }
      before do
        complete_work.check_out_by!(worker)
        complete_work.finish!
        complete_work.review!
      end

      its(:complete_works) { should include(complete_work) }
    end
  end
end

