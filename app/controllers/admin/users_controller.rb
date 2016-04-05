class Admin::UsersController < Admin::DashboardController

  before_action :find_user, only: [:destroy, :show]
  before_action :load_users, only: :index

  def index
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:info] = t "user.deleted"
      redirect_to users_path
    else
      flash[:danger] = t "user.deleted_error"
      redirect_to users_path
    end
  end

  private
  def load_users
    if params[:user].present?
      @users = User.name_like params[:user][:name]
    end
    @users ||= User.all
    @users = @users.paginate page: params[:page]
  end
end
