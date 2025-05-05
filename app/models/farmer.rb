class Farmer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :reservations, through: :items
  has_many :comments, as: :sender, dependent: :destroy
  has_many :dm_messages, as: :sender, dependent: :destroy
end
