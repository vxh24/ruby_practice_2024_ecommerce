class SessionsController < ApplicationController
  before_action :auth_user_path, only: :new

  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      if user.activated?
        handle_session_management(user)
      else
        handle_inactive_user
      end
    else
      handle_invalid_credentials
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def auth_user_path
    return if current_user.nil?

    redirect_to current_user.present? && current_user.admin? ? admin_root_path : root_path
  end

  def handle_session_management user
    forwarding_url = session[:forwarding_url]
    reset_session
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    log_in user
    if user.admin?
      redirect_to admin_root_path
    else
      redirect_to forwarding_url || user
    end
  end

  def handle_inactive_user
    flash[:warning] = "Account not activated. " \
                  "Check your email for the activation link."
    redirect_to root_url, status: :see_other
  end

  def handle_invalid_credentials
    flash.now[:danger] = t("invalid_email_password_combination")
    render :new, status: :unprocessable_entity
  end
end
