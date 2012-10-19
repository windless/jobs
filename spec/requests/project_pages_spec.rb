# encoding: utf-8

require 'spec_helper'

describe "ProjectPages" do
  subject { page }

  describe "index page" do
    let(:user) { FactoryGirl.create :user }

    before do
      sign_in user
      visit projects_path
    end

    it { should have_selector('title', text: 'Projects') }
    it { should have_selector('h1', text: 'Projects') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:project, user: user) } }
      after(:all) do
        Project.delete_all
      end

      it { should have_selector('div.pagination') }

      it "lists each project" do
        Project.paginate(page: 1, per_page: 10).each do |project|
          page.should have_selector("div.project#project_#{project.id}")
        end
      end
    end
  end
end
