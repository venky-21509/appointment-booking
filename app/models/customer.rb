class Customer < ApplicationRecord

  has_many :appointments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_associations(auth_object = nil)
    ["appointments"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "email", "first_name", "gender", "id", "last_name", "mobile", "updated_at"]
  end

  def to_s
    full_name = "#{first_name} #{last_name}".strip
    full_name.present? ? full_name : email
  end

end 

