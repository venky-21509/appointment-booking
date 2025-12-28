require "rails_helper"

RSpec.describe Appointment, type: :model do 
  
  let(:valid_attributes) do
    {
      time: Time.current,
      package: "Basic",
      provider: "Provider A"
    }
  end

  it "is valid with valid attributes" do
    appointment = Appointment.new(valid_attributes)
    expect(appointment).to be_valid 
  end

  it "generates unique_id before validation" do 
    appointment = Appointment.create!(valid_attributes)
    expect(appointment.unique_id).to be_present
  end
 
 it "is invalid without time" do
  appointment = Appointment.new(package: "Basic", provider: "Provider A")
  appointment.valid?
  expect(appointment.errors[:time]).to be_present
end

 it"accepts only allowed packages" do 
   appointment = Appointment.new(valid_attributes.merge(package: "Invalid"))
   expect(appointment).not_to be_valid
 end
 it "accepts only allowed providers" do
   appointment = Appointment.new(valid_attributes.merge(provider: "Invalid"))
   expect(appointment).not_to be_valid
 end 

it "has default status as new" do
  appointment = Appointment.create!(valid_attributes)
  expect(appointment.status).to eq("new")

end

it "allows status transition using AASM" do 
  appointment = Appointment.create!(valid_attributes)
  appointment.confirm! 
  expect(appointment.status).to eq("confirmed")
end

end