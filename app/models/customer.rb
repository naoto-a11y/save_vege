class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image

  has_many :follows, dependent: :destroy
  has_many :followed_farmers, through: :follows, source: :farmer
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  has_many :reservations, dependent: :destroy
  has_many :comments, as: :sender, dependent: :destroy
  has_many :dm_messages, as: :sender, dependent: :destroy

  def get_profile_image
    if self.profile_image.attached?
      self.profile_image
    else
      'no_image.jpg'
    end
  end

  def following?(farmer)
    follows.exists?(farmer_id: farmer.id)
  end
end
