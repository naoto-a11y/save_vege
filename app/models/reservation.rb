class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one :dm_room, dependent: :destroy

  validates :reserved_date, presence: true

  enum cancellation_reason: {
  # 消費者側
  customer_change_of_mind: 10,
  ordered_by_mistake: 11,
  

  # 農家側
  farmer_out_of_stock: 0,
  harvest_failure: 1,
  logistics_issue: 2,
  
  # 共通
  other: 99,
  schedule_conflict: 98
}

enum status: {
  in_progress: 0,
  completed: 1,
  canceled: 2
}
end
