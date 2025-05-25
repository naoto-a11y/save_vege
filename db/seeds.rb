# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# タグを事前に作成（15個程度用意）
tag_names = %w[有機栽培 無農薬 甘い おいしい 朝採れ 春野菜 夏野菜 冬野菜 土付き 葉物 根菜 果菜 露地栽培 ハウス栽培 新鮮]
tags = tag_names.map { |name| Tag.find_or_create_by!(tag_name: name) }

# 農家を3人作成
3.times do |i|
  farmer = Farmer.create!(
    email: "farmer#{i + 1}@example.com",
    password: "password",
    last_name: "農家#{i + 1}",
    first_name: "太郎",
    last_name_kana: "ノウカ",
    first_name_kana: "タロウ",
    postal_code: "100000#{i}",
    seller_address: "東京都渋谷区#{i + 1}丁目",
    introduction: "テスト農家#{i + 1}の紹介文です",
    prefecture: "東京都"
  )

  # 各農家に10個商品を持たせる
  10.times do |j|
    item = farmer.items.create!(
      name: "テスト野菜#{j + 1}",
      introduction: "これはテスト野菜#{j + 1}の紹介文です。",
      harvest_date: Date.today + j.days,
      price: rand(100..500),
      category_id: Category.first&.id || Category.create!(name: "野菜").id
    )

    # ランダムにタグを5つ関連付け
    item.tags = tags.sample(5)
  end
end

# カスタマー（ユーザー）を3人作成
3.times do |i|
  Customer.create!(
    email: "customer#{i + 1}@example.com",
    password: "password",
    last_name: "利用者#{i + 1}",
    first_name: "花子",
    last_name_kana: "リヨウシャ",
    first_name_kana: "ハナコ",
    telephone_number: "0901234567#{i}",
    introduction: "テスト顧客#{i + 1}です"
  )
end

puts "✅ 農家・商品・タグ・ユーザーのテストデータを作成しました"