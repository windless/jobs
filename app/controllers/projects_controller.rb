class ProjectsController < ApplicationController
  before_filter :sign_in_user, only: [:index]

  def index
    @projects = Project.search(params[:search], params[:page])
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
  end

  private

  def sign_in_user
    redirect_to signin_path unless signed_in?
  end
end
