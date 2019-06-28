class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def new
    @appointment = Appointment.new
  end

  def create
    appointment = Appointment.create(user_id: current_user.id, date: get_date_from_params())

    if appointment.valid?
      redirect_to root_path
    end
  end

  def get_availability
    #temporary
    params.select { | key, _ | :year || :month || :day }.permit!

    #DateTime.new(year, month, day, hour, minute = 0, second = 0, timezone = '-0400')
    chosen_day = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)

    range = (chosen_day.beginning_of_day + 9.hours)..(chosen_day.end_of_day - 6.hours)

    render json: Appointment.where(date: range).pluck(:date)
  end

  private

    #works simply because there's no 9-5 overlap
    def standard_to_military_time(hour)
      hour = hour.match(/\d+/)[0].to_i

      hour < 9 ? (hour + 12) : (hour)
    end

    def get_date_from_params
      year, month, day, hour = [ 
        params[:year], 
        params[:month], 
        params[:day], 
        standard_to_military_time(params[:hour]) 
      ].map(&:to_i)
  
      DateTime.new(year, month, day, hour, 0, 0)
    end

end
