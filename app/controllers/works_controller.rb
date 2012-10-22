class WorksController < ApplicationController
  def create
    @sprint = Sprint.find(params[:sprint_id])
    @work = @sprint.works.create!(params[:work])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
