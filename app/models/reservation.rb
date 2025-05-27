class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one :dm_room, dependent: :destroy

  validates :reserved_date, presence: true
end
