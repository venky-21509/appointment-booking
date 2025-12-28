module Api
  class AppointmentsController < ApplicationController
    protect_from_forgery with: :null_session
   skip_before_action :authenticate_customer!
    skip_before_action :verify_authenticity_token
    def index
      appointments = Appointment.order(created_at: :desc)
      render json: appointments
    end

    def show
      appointment = Appointment.find(params[:id])
      render json: appointment
    end

    def create
      appointment = Appointment.new(appointment_params)

      if appointment.save
        render json: appointment, status: :created
      else
        render json: { errors: appointment.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      appointment = Appointment.find(params[:id])

      if appointment.update(appointment_params)
        render json: appointment
      else
        render json: { errors: appointment.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      appointment = Appointment.find(params[:id])
      appointment.destroy

      render json: { message: "Appointment deleted successfully" }
    end

    private

    def appointment_params
      params.require(:appointment)
            .permit(:time, :package, :provider, :attachment)
    end
   end
end
