# encoding: utf-8

class ProjectsController < ApplicationController
  before_filter :sign_in_user

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
    @project = Project.find(params[:id])
  end

  private

  def sign_in_user
    redirect_to signin_path, notice: "访问被拒绝，你可能没有权限或登录" unless signed_in?
  end
end
