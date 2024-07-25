class UsersController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :load_user, only: :show
  before_action :correct_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = "User not found!"
    redirect_to root_url
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = "You cannot show this account."
    redirect_to root_url
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
