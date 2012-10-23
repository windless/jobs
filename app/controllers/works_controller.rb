class WorksController < ApplicationController
  def create
    @sprint = Sprint.find(params[:sprint_id])
    @work = @sprint.works.create!(params[:work])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def checkout
    Work.find(params[:id]).check_out_by!(current_user)
    redirect_to :back
  end

  def finish
    Work.find(params[:id]).finish!
    redirect_to :back
  end

  def review
    Work.find(params[:id]).review!
    redirect_to :back
  end
end
