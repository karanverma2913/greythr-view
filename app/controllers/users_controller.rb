# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, expect: [:create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def home
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = Employee.new(user_params)
    @user.balance = set_leave_balance(@user)
    if @user.save
      flash[:created] = 'User Created'
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employee = current_user
  end

  def update
    @employee = User.find(params[:id])
    redirect_to status_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role, :joining_date, :salary)
  end

  def update_params
    params.permit(:name, :password)
  end

  def set_leave_balance(object)
    month = 12 - object.joining_date.strftime('%m').to_i
    if month.positive?
      month += 1
      1.5 * month
    else
      1.5
    end
  end
end
