class AppointmentMailer < ApplicationMailer
  default from: ENV.fetch("MAILER_FROM", "venkeypothem21@gmail.com")  
  
  def appointment_created
    @appointment = params[:appointment] 
    @customer = @appointment.customer
    mail(
      to: @customer.email,      
      subject: "Confirmation: Your Appointment #{@appointment.unique_id}"
    )
  end
end
