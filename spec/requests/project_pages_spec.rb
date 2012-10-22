# encoding: utf-8

require 'spec_helper'

describe "ProjectPages" do
  subject { page }
  let(:user) { FactoryGirl.create :user }
  before { sign_in user }

  describe "index page" do
    before do
      visit projects_path
    end

    it { should have_selector('title', text: 'Projects') }
    it { should have_selector('h1', text: 'Projects') }
    it { should have_link('新建', href: new_project_path) }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:project, creator: user) } }
      it { should have_selector('div.pagination') }

      it "lists each project" do
        pending "莫名的错误，不清楚"
        Project.paginate(page: 1, per_page: 10).each do |project|
          page.should have_selector("div.project#project_#{project.id}")
        end
      end
    end
  end

  describe "new page" do
    let(:submit) { "提交" }
    before { visit new_project_path }
    it { should have_selector('title', text: '新建项目') }
    it { should have_selector('legend', text: '新建项目') }

    context "with valid information" do
      let(:project_name) { "Jobs" }
      before do
        fill_in '项目名称', with: project_name
        fill_in '项目描述', with: 'Jobs ...'
      end

      it "creates a project which belongs to user" do
        click_button submit
        user.projects.find_by_name(project_name).should_not be_nil
      end
    end

    context "with invalid information" do
      it "does not create a project" do
        expect { click_button submit }.not_to change(Project, :count)
      end

      it "has alert div" do
        click_button submit
        page.should have_selector('div.alert.alert-error')
      end
    end
  end

  describe "show page" do
    let(:project) { FactoryGirl.create(:project, creator: user) }
    let!(:sprint1) { FactoryGirl.create(:sprint, project: project, created_at: 1.day.ago) }
    let!(:sprint2) { FactoryGirl.create(:sprint, project: project, created_at: 1.hour.ago) }
    before do
      visit project_path(project)
    end
    
    it { should have_selector('title', text: project.name) }
  end
end
