class Farmer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :prefecture, presence: true

  has_one_attached :profile_image

  has_many :items, dependent: :destroy
  has_many :reservations, through: :items
  has_many :comments, as: :sender, dependent: :destroy
  has_many :dm_messages, as: :sender, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :customer

  geocoded_by :seller_address
  after_validation :geocode, if: :will_save_change_to_seller_address?

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :seller_address, presence: true
  validates :introduction, length: { maximum: 200 }
  
  def get_profile_image
    if self.profile_image.attached?
      self.profile_image
    else
      'no_image.jpg'
    end
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

  PREFECTURES = [
  "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
  "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
  "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県",
  "岐阜県", "静岡県", "愛知県", "三重県",
  "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
  "鳥取県", "島根県", "岡山県", "広島県", "山口県",
  "徳島県", "香川県", "愛媛県", "高知県",
  "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
  ]
end
