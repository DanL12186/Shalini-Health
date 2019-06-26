class AppointmentsController < ApplicationController
  
  def new
    @appointment = Appointment.new
  end

  def get_availability
    #temporary
    params.select { | key, _ | :year || :month || :day }.permit!

    #DateTime.new(Time.now.year, Time.now.month, Time.now.day, 12, 0, 0, '-0400')
    chosen_day = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)

    #find dates matching a range (in this case, one day)
    #09:00 - 17:00 (technically 17:59 (5:59pm); work this out later)
    range = (chosen_day.beginning_of_day + 9.hours)..(chosen_day.end_of_day - 6.hours)

    render json: Appointment.where(date: range).pluck(:date)
  end

end
