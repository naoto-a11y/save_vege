class Category < ApplicationRecord
  has_many :items, dependent: :nullify
  validates :name, presence: true

  def self.ensure_defaults
    %w[野菜 果物 米・穀類 きのこ類 根菜 豆類・豆製品 加工品 詰め合わせ ハーブ・香草 規格外品・訳アリ品 ].each do |name|
      find_or_create_by!(name: name)
    end
  end
end
