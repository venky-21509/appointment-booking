class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "venkeypothem21@gmail.com")
  layout "mailer"
end
