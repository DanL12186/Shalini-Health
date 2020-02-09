class AppointmentsController < ApplicationController
  include TimeConversion
  
  def new
    redirect_to root_path unless logged_in?
    @appointment = Appointment.new
  end

  def create
    date = get_date_from_params
    appointment = Appointment.create(user_id: current_user.id, date: date)

    if appointment.valid?
      respond_to do | format |
        human_readable_date = format_date(date)

        #mail both Shalani and the user about upcoming appointment
        UserMailer.with(user: current_user, appointment_date: human_readable_date).appointment_email.deliver_later
        ShalaniMailer.with(user: current_user, appointment_date: human_readable_date).appointment_email.deliver_later
  
        format.html { redirect_to(current_user, notice: 'User was successfully created.') }
        format.json { render json: current_user, status: :created, location: current_user }
      end
    end
  end

  def destroy
    Appointment.find(params[:id]).destroy
    redirect_to current_user
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

    def get_date_from_params
      year, month, day, hour = [ 
        params[:year], 
        params[:month], 
        params[:day], 
        convert_hour(params[:hour].to_i, convert_to = 'military')
      ].map(&:to_i)
  
      DateTime.new(year, month, day, hour, 0, 0)
    end

end
