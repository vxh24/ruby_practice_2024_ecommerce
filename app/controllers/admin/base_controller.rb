class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :authorize_admin

  private

  def authorize_admin
    redirect_to login_url if session[:user_id].nil? || !is_admin
  end

  def is_admin
    user = User.find_by id: session[:user_id]
    return user.admin?
  end
end
