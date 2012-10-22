class SprintsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.new
  end

  def create
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.create(params[:sprint])
    @sprint.save
    redirect_to @project
  end
end
