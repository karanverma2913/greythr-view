class UsersController < ApplicationController
  before_action :authenticate_user, except: :welcome

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def welcome
  end

  def home
    @current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = Employee.new(user_params)
    if @user.save
      flash[:created] = 'User Created'
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def status
    @current_user
  end

  def edit
    @emoloyee = @current_user
  end

  def update
    @employee = User.find(params[:id])
    if @employee.update(update_params)
      redirect_to status_path
    else
      redirect_to status_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role, :joining_date, :salary)
  end

  def update_params
    params.permit(:name, :password)
  end
end
