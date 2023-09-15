# frozen_string_literal: true

class LeaveRequestsController < ApplicationController
  def index
    @leave_requests = LeaveRequest.all
  end

  def new
    @leave_request = LeaveRequest.new
  end

  def show
    @leave_request = LeaveRequest.find(params[:id])
  end

  def create
    last_request = current_user.leave_requests.last
    raise unless last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'

    @leave_request = current_user.leave_requests.new(leave_params)
    dif = @leave_request.end_date - @leave_request.start_date
    raise if current_user.balance <= dif.to_i + 1

    @leave_request.days = dif.to_i + 1
    @leave_request.status = 'pending'
    current_user.balance = current_user.balance - @leave_request.days
    if @leave_request.save && current_user.save
      flash[:notice] = 'Applied Successfully !'
      redirect_to history_path
    else
      render :new, status: :unprocessable_entity
    end
  rescue StandardError
    flash[:notice] = 'Not enough balance or Last request is pending !'
    redirect_to root_path
  end

  def destroy
    last_request = current_user.leave_requests.last
    raise if last_request.nil? || last_request.status != 'pending'

    current_user.update(balance: current_user.balance + last_request.days)
    last_request.destroy!
    render json: { message: 'Leave Request Deleted !' }, status: :ok
  rescue StandardError
    render json: { error: 'Theirs is nothing to Deleted' }, status: :unprocessable_entity
  end

  def approve_request
    leave_request = LeaveRequest.find(params[:id])
    raise if leave_request.status != 'pending'

    leave_request.status = 'approved'
    leave_request.save
    flash[:approved] = 'Leave Request Approved ! '
    redirect_to all_leave_request_path
  rescue StandardError
    flash[:notice] = 'Already approved or rejected'
    redirect_to all_leave_request_path
  end

  def reject_request
    leave_request = LeaveRequest.find_by(id: params[:id])
    raise if leave_request.status != 'pending'

    current_user = User.find_by(id: leave_request.user_id)
    current_user.update(balance: current_user.balance + leave_request.days)
    leave_request.status = 'rejected'
    leave_request.save
    flash[:rejected] = 'Leave Request Rejected  ! '
    redirect_to all_leave_request_path
  rescue StandardError
    flash[:notice] = 'Already approved or rejected'
    redirect_to all_leave_request_path
  end

  def history
    @leave_request = current_user.leave_requests.all
  end

  private

  def leave_params
    params.require(:leave_request).permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
  end
end
