# encoding: utf-8

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      redirect_to root_path
    else
      flash.now[:error] = "帐号或密码错误"
      render 'new'
    end
  end
end
