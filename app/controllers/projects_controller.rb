class ProjectsController < ApplicationController
  before_filter :sign_in_user, only: [:index]
  def index
    @projects = Project.search(params[:search], params[:page])
  end

  private

  def sign_in_user
    redirect_to signin_path unless signed_in?
  end
end
