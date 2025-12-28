  require "csv"
class Appointment < ApplicationRecord

  PACKAGE_OPTIONS = ["Basic", "Silver", "Gold", "Diamond", "Premium"].freeze
  PROVIDER_OPTIONS = ["Provider A", "Provider B", "Provider C", "Provider X"].freeze

  include AASM

  mount_uploader :attachment, AttachmentUploader

  before_validation :generate_unique_id, on: :create

  validates :time, presence: true 

  validates :package, presence: true, inclusion: { in: PACKAGE_OPTIONS  }
  validates :provider, presence: true, inclusion: { in: PROVIDER_OPTIONS }
  validates :unique_id, presence: true, uniqueness: true 
  validates :status, presence: true 
  

  aasm column: :status do
    state :new, initial: true
    state :confirmed
    state :completed
    state :received
    state :cancelled

    event :confirm do
      transitions from: :new, to: :confirmed
    end

    event :complete do
      transitions from: :confirmed, to: :completed
    end

    event :receive do
      transitions from: :completed, to: :received
    end

    event :cancel do
      transitions from: [:new, :confirmed, :completed, :received], to: :cancelled
    end
  end

  scope :search, ->(query) {
    where("unique_id LIKE :q OR provider LIKE :q OR package LIKE :q OR status LIKE :q", q: "%#{query}%")
  }

  # after_create_commit :send_appointment_created_email

  # private

  # def send_appointment_created_email
  #   AppointmentMailer
  #     .with(appointment: self)
  #     .appointment_created
  #     .deliver_later
  # end
  


  def self.to_csv
    attributes = %w[id unique_id time status package provider created_at ]

    CSV.generate(headers: true) do | csv |
      csv << attributes 
      all.find_each do |appointment|
        csv << attributes.map { |attr| appointment.send(attr)}
      end
    end
  end

private

  def generate_unique_id
    self.unique_id ||= "APT-#{SecureRandom.hex(4).upcase}"
  end


end
