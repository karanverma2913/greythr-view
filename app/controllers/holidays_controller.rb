class HolidaysController < ApplicationController

  def index
    @holidays = Holiday.all
  end
  def show
    @holiday = Holiday.find(params[:id])
  end

  def new
    @holiday = Holiday.new
  end

  def create
    @holiday = Holiday.new(holiday_params)
    if @holiday.save
      redirect_to holiday_path(@holiday)
    else
      render 'new'
    end
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def update
    @holiday = Holiday.find(params[:id])
    if @holiday.update(holiday_params)
      redirect_to holidays_show(@holiday)
    else
      render 'edit'
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy
    redirect_to holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:name, :date)
  end
end
