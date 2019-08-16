class Recipe < ApplicationRecord
  validates :name, uniqueness: :true
end
