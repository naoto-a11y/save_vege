class Category < ApplicationRecord
  has_many :items, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
