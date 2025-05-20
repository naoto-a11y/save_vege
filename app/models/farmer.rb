class Farmer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :items, dependent: :destroy
  has_many :reservations, through: :items
  has_many :comments, as: :sender, dependent: :destroy
  has_many :dm_messages, as: :sender, dependent: :destroy

  geocoded_by :seller_address
  after_validation :geocode, if: :will_save_change_to_seller_address?

  def get_profile_image
    if self.profile_image.attached?
      self.profile_image
    else
      'no_image.jpg'
    end
  end
end
