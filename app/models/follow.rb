class Follow < ApplicationRecord
  belongs_to :customer
  belongs_to :farmer

  validates :customer_id, uniqueness: { scope: :farmer_id }
end
