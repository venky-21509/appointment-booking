# app/models/appointment.rb
class Appointment < ApplicationRecord
  include AASM

  #before_validation :normalize_status

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
 # private

  # def normalize_status
  #   self.status = status.to_s.downcase if status.present?
  # end
end
