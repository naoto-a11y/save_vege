class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :farmer
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customers
  has_many :comments, dependent: :destroy
  has_many :reservations, dependent: :destroy

  attr_accessor :tag_names



  def save_tags(tag_names)
    tag_names.each do |new_name|
      tag = Tag.find_or_create_by(tag_name: new_name)
      unless self.tags.include?(tag)
        self.tags << tag
      end
    end
  end

  def get_image
    if self.image.attached?
      self.image
    else
      'no_image.jpg'
    end
  end

  
end
