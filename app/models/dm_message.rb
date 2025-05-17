class DmMessage < ApplicationRecord
  belongs_to :dm_room
  belongs_to :sender, polymorphic: true
  has_one :reservation, through: :dm_room

  validates :message, presence: true
end
