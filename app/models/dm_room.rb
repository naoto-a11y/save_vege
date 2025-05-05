class DmRoom < ApplicationRecord
  belongs_to :reservation
  has_many :dm_messages, dependent: :destroy
end
