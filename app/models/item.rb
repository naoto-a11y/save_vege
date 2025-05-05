class Item < ApplicationRecord
  belomgs_to :farmer
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customers
  has_many :comments, dependent: :destroy
  has_many :reservations, dependent: :destroy

end
