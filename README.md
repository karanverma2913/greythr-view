# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

    @user = User.find_by(email: params[:email], password: params[:password])
    session[:current_user] = jwt_encode(email: @user.email)
    if @user.nil?
      raise
    elsif @user.type == 'Employee' && @user.type == 'Hr'
      redirect_to root_path
    end
  rescue StandardError
    flash[:notice] = 'You are not authorized(Login First)'
    redirect_to root_path
  end
