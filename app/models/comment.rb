class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :sender, polymorphic: true

  validates :comment, presence: true, length: { maximum: 200 }
  private


end
