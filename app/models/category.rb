class Category < ApplicationRecord
  has_many :items, dependent: :nullify

  validates :name, presence: true
end
