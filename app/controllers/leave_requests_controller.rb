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
    if dif = check_request_criteria()
      @leave_request = current_user.leave_requests.new(leave_params)
      @leave_request.days, @leave_request.status = dif.to_i + 1, 'pending'
      current_user.balance -= @leave_request.days
    end
    if @leave_request && current_user
      flash[:notice] = 'Applied Successfully !'
      redirect_to history_path
    else
      render :new, status: :unprocessable_entity
    end
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
    flash[:notice] = 'Leave request already approved or rejected'
    redirect_to all_leave_request_path
  end

  def reject_request
    leave_request = LeaveRequest.find_by(id: params[:id])
    raise if leave_request.status != 'pending'

    user = User.find_by(id: leave_request.user_id)
    user.update(balance: user.balance + leave_request.days)
    leave_request.status = 'rejected'
    leave_request.save
    flash[:rejected] = 'Leave Request Rejected  ! '
    redirect_to all_leave_request_path
  rescue StandardError
    flash[:notice] = 'Leave request already approved or rejected'
    redirect_to all_leave_request_path
  end

  def history
    @leave_request = current_user.leave_requests.all
  end

  private

  def leave_params
    params.require(:leave_request).permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
  end

  def check_request_criteria
    debugger
    last_request = current_user.leave_requests.last
    raise if last_request.nil? || leave_params[:start_date] > last_request.end_date
    (last_request.start_date .. last_request.end_date).cover?(leave_params[:start_date] || leave_params[:end_date])
    dif = leave_params[:end_date].to_i - leave_params[:start_date].to_i
    raise if current_user.balance < dif + 1
    return dif
  rescue StandardError
    flash[:notice] = 'Not enough balance or Last request is pending !'
    return false
  end
end
