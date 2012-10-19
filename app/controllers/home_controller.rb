class HomeController < ApplicationController
  def index
    @projects = current_user.projects.paginate(page: params[:page], per_page: 10) if signed_in?
  end
end
