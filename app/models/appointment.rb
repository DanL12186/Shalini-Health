class Appointment < ApplicationRecord
  belongs_to :user

  validates :date, uniqueness: true, presence: true
end