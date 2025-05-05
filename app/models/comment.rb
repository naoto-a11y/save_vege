class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :sender, polymorphic: true
end
