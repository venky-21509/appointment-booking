class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy,
                                         :confirm, :complete, :receive, :cancel]

  def index
    @appointments = current_customer.appointments.order(created_at: :desc)
    @appointments = @appointments.search(params[:search]) if params[:search].present?
  
    respond_to do |format| 
      format.html do 
        @appointments = @appointments.page(params[:page]).per(5)
      end
    
      format.csv do 
        send_data @appointments.to_csv, 
                 filename: "appointments-#{Date.today}.csv"
      end
    end
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    Appointment.transaction do
      @appointment = current_customer.appointments.build(appointment_params)

      if @appointment.save
        AppointmentMailer.with(appointment: @appointment).appointment_created.deliver_later
        redirect_to appointments_path, notice: "Saved successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotUnique
    flash[:alert] = "This time slot is already booked. Please choose another."
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "updated successfully", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "deleted successfully"
  end

  
  def confirm
    @appointment.confirm!
    redirect_to appointments_path, notice: "Appointment confirmed"
  end

  def complete
    @appointment.complete!
    redirect_to appointments_path, notice: "Appointment completed"
  end

  def receive
    @appointment.receive!
    redirect_to appointments_path, notice: "Appointment received"
  end

  def cancel
    @appointment.cancel!
    redirect_to appointments_path, alert: "Appointment cancelled"
  end

  private

  def set_appointment
    @appointment = current_customer.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment)
          .permit(:time, :package, :provider, :attachment)
  end
end
