class AppointmentMailer < ApplicationMailer
  default from: "venkeypothem67@gmail.com"  
  def appointment_created
    @appointment = params[:appointment] 
    mail(
      to: "venkeypothem21@gmail.com",      
      subject: "New Appointment Created"
    )
  end
end
