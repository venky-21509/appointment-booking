class AppointmentMailer < ApplicationMailer
  default from: "venkeypothem67@gmail.com"  
  def appointment_created
    @appointment = params[:appointment] 
    @customer = @appointment.customer
    mail(
      to: @customer.email,      
      subject: "Confirmation: Your Appointment #{@appointment.unique_id}"
    )
  end
end
