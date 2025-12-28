class AppointmentWorker
  include Sidekiq::Worker


  sidekiq_options queue: :default, retry: 5

  def perform(appointment_id)
    appointment = Appointment.find_by(id: appointment_id)
    return unless appointment

    AppointmentMailer
      .with(appointment: appointment)
      .appointment_created
      .deliver_later
    
  end
end