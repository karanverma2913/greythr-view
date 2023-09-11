# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, except: :welcome
  # load_and_authorize_resource except: [:welcome, :home]
  def show
    @user = User.find(params[:id])
  end

  def welcome; end

  def home
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = Employee.new(user_params)
    if @user.save
      flash[:created] = 'User Created'
      redirect_to home_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def status
    @current_user
  end

  def edit
    @employee = @current_user
  end

  def update
    @employee = User.find(params[:id])
    redirect_to status_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to home_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role, :joining_date, :salary)
  end

  def update_params
    params.permit(:name, :password)
  end
end
