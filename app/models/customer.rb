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

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :telephone_number, presence: true
  validates :introduction, length: { maximum: 200 }

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
  #予約されているかどうか
  def reserved_item?(item)
    item.reservations.exists?(customer_id: id, status: :in_progress)
  end
  #予約されているitemを取得
  def reservation_for(item)
    reservations.find_by(item_id: item.id)
  end
   # item をお気に入り済みか
  def favorited?(item)
    favorites.exists?(item_id: item.id)
  end
  #item に対して持つ Favorite レコード1件を取得
  def favorite_for(item)
    favorites.find_by(item_id: item.id)
  end

   # ログイン可能か判定
   def active_for_authentication?
    super && status 
   end

  # ログイン拒否時のメッセージ
  def inactive_message
    if status
      super
    else
      :deleted_account
    end
  end
end
