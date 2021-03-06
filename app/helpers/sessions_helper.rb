module SessionsHelper

  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    end
  end

  def current_user? user
    user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "log_in.please"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    unless current_user? @user
      flash[:danger] = t "user.isnt_authorized"
      redirect_to root_path
    end
  end

  def guest
    if logged_in?
      flash[:danger] = t "user.already_logged"
      redirect_to root_path
    end
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def verify_admin_user
    unless current_user.admin?
      flash[:danger] = t "user.isnt_permission"
      redirect_to root_path
    end
  end

  def admin_user?
    current_user.admin? if logged_in?
  end

  def verify_normal_user
    if current_user.admin?
      flash[:danger] = t "user.normal_only"
      redirect_to admin_path
    end
  end

  def home_page
    if logged_in?
      redirect_to admin_user? ? admin_path : user_path(current_user)
    end
  end
end
