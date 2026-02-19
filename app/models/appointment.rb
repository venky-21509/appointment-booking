
require "csv"

class Appointment < ApplicationRecord

  belongs_to :customer 
  
  include AASM
  include AppointmentGuard::Validator

  mount_uploader :attachment, AttachmentUploader

  PACKAGE_OPTIONS  = ["Basic", "Silver", "Gold", "Diamond", "Premium"].freeze
  PROVIDER_OPTIONS = ["Provider A", "Provider B", "Provider C", "Provider X"].freeze

  before_validation :generate_unique_id, on: :create 
  
  before_validation :normalize_time 

  validates :time, presence: true
  validates :package, presence: true, inclusion: { in: PACKAGE_OPTIONS }
  validates :provider, presence: true, inclusion: { in: PROVIDER_OPTIONS }
  validates :unique_id, presence: true, uniqueness: true
  validates :status, presence: true

  validate :prevent_time_conflict

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
    where(
      "unique_id LIKE :q OR provider LIKE :q OR package LIKE :q OR status LIKE :q",
      q: "%#{query}%"
    )
  }

  def self.to_csv
    attributes = %w[id unique_id time status package provider created_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      find_each do |appointment|
        csv << attributes.map { |attr| appointment.public_send(attr) }
      end
    end
  end


  def prevent_time_conflict
    validate_time_conflict(
      record: self,
      start_time: time,
      scope: Appointment.where(provider: provider).where.not(id: id)
    )
  end

  private

  def generate_unique_id
    self.unique_id ||= "APT-#{SecureRandom.hex(4).upcase}"
  end
end

def normalize_time
  return if time.blank?

  rounded_minutes = (time.min / 30) * 30
  self.time = time.change(min: rounded_minutes, sec: 0)
end

