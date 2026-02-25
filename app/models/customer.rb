class Customer < ApplicationRecord

  has_many :appointments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_associations(auth_object = nil)
    ["appointments"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "email", "first_name", "gender", "id", "last_name", "mobile", "updated_at"]
  end
end
