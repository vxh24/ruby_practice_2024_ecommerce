class SessionsController < ApplicationController
  def new; end
  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        redirect_to forwarding_url || user
      else
        flash[:warning] = "Account not activated. Check your email for the activationlink."
        redirect_to root_url, status: :see_other
      end
    else
      # Create an error message.
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
