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
    @work = Work.find(params[:id])
    @work.check_out_by!(current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def finish
    @work = Work.find(params[:id])
    @work.finish!
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def review
    @work = Work.find(params[:id])
    @work.review!
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    Work.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'destroy', locals: { id: params[:id] } }
    end
  end
end
