class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "log_in.success"
      redirect_to root_url
    else
      flash[:danger] = t "log_in.invalid"
      redirect_to root_url
    end
  end

  def destroy
    log_out
    flash[:info] = t "log_out.info"
    redirect_to root_url
  end

  private
  def session_params
    params.require(:session).permit :email, :password
  end
end
