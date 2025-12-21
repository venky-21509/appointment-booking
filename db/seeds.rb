# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

50.times do 
  Appointment.create(
 time: Faker::Time.between(from: 1.month.ago, to: Time.now),
 status: ["New","confirmed","completed","recieved","cancelled"].sample,
 package: ["Basic","Silver","Gold","Diamond","Premium"].sample,
 provider: ["Provider A","Provider B","Provider C","Provider X"].sample,
 unique_id: Faker::Internet.unique.uuid 

  )
end 
