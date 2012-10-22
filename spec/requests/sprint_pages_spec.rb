# encoding: utf-8

require 'spec_helper'

describe "SprintPages" do
  subject { page }
  let(:user) { FactoryGirl.create :user }
  before { sign_in user }

  describe "new page" do
    let(:project) { FactoryGirl.create :project, creator: user }
    before { visit new_project_sprint_path(project) }
    it { should have_selector("title", text: "新的Sprint") }

    it "creates a sprint" do
      expect { click_button "提交" }.to change(Sprint, :count).by(1)
    end

    describe "redirection" do
      before { click_button "提交" }
      it { should have_selector('title', text: project.name) }
    end
  end
end
