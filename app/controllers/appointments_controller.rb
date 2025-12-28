class AppointmentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy,
                                         :confirm, :complete, :receive, :cancel]

 def index
  @appointments = Appointment.order(created_at: :desc)
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
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      AppointmentWorker.perform_async(@appointment.id)
      redirect_to appointments_path, notice: "saved successfully"
    else
      Rails.logger.debug @appointment.errors.full_messages 

      render :new, status: :unprocessable_entity 
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "updated successfully"
    else
      render :edit
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
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment)
          .permit(:time, :package, :provider, :attachment)
  end
end
