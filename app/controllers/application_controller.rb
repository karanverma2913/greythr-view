class ApplicationController < ActionController::Base
  include JsonWebToken
  before_action :authenticate_user, except: [:login]

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    raise if @user.nil?
    if @user.type == 'Employee'
      redirect_to home_path
      session[:current_user] = jwt_encode(email: @user.email)
    elsif @user.type == 'Hr'
      session[:current_user] = jwt_encode(email: @user.email)
      redirect_to home_path
    else
      raise
    end
  rescue
    flash[:notice] = 'You are not authorized(Login First)'
    redirect_to root_path
  end

  def logout
    session.delete(:current_user)
    @current_user = nil
    redirect_to root_url, status: :see_other
  end

  private
    def authenticate_user
      decoded = jwt_decode(session[:current_user].split(' ').last)
      @current_user = User.find_by_email(decoded[:email])
      raise unless @current_user.present?
    rescue StandardError
      flash[:notice] = 'You are not authorized(Login First)'
      redirect_to root_path
    end
end
