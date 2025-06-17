class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :farmer
  belongs_to :category, optional: true
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customers
  has_many :comments, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :available_slots, dependent: :destroy

  attr_accessor :tag_names
  accepts_nested_attributes_for :available_slots, allow_destroy: true, reject_if: :reject_available_slot

  scope :active, -> { where(is_active: true) }


  validates :name, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :introduction, length: { maximum: 200 }

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

  def deactivate_if_expired
    latest_end_date = available_slots.maximum(:available_date)
  
    if latest_end_date.present? && latest_end_date < Time.current
      if is_active == true
        update(is_active: false)
      end
    end
  end

  private

  def reject_available_slot(attributes)
    id = attributes[:id].present?
    available_date = attributes[:available_date].present?
    attributes.merge!(_destroy: 1) if id && !available_date
  end
end
