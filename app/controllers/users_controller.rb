class UsersController < ApplicationController

  before_action :logged_in_user, except: [:new, :create]
  before_action :normal_user, only: :index
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:following, :followers, :show]
  before_action :find_activities, only: :show

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "sign_up.create"
      redirect_to root_url
    else
      flash[:danger] = t "sign_up.error"
      render :new
    end
  end

  def show
    unless @user
      flash[:danger] = t "user.doesnt_exist"
      redirect_to root_url
    end
    if params[:option].present?
      @option = params[:option]
      @users = @user.send(@option).paginate page: params[:page]
      @title = t "user.#{@option}"
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes user_params
      flash[:success] = t "user.info_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def find_activities
    @feed_items = current_user.feeds.paginate page: params[:page]
  end
end
