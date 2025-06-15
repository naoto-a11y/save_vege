# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
farmer = Farmer.first
category = Category.find_or_create_by!(name: "野菜")

# タグを事前に用意しておく
tag_names = ["旬", "訳アリ", "お得"]
tags = tag_names.map { |name| Tag.find_or_create_by!(tag_name: name) }

item_names = ["にんじん", "キャベツ", "レタス", "トマト", "ジャガイモ", "レタス", "お米", "詰め合わせ", "セロリ", "カブ"]

item_names.each_with_index do |name, i|
  item = Item.create!(
    farmer: farmer,
    category: category,
    name: "旬の#{name}",
    introduction: "新鮮な#{name}をお届けします。",
    harvest_date: Date.today,
    price: 300 + i * 20,
    is_active: true
  )

  # 画像添付（画像ファイルの存在が前提）
  item.image.attach(
    io: File.open(Rails.root.join("app/assets/images/no_image.jpg")),
    filename: "no_image.jpg",
    content_type: "image/jpeg"
  )

  # タグ追加
  tags.each { |tag| item.tags << tag }

  # 受取可能日を5つ追加（今日から20〜24日後）
  5.times do |j|
    item.available_slots.create!(available_date: Date.today + 20 + j)
  end
end


20.times do |i|
  Farmer.find_or_create_by!(email: "farmer#{i + 1}@example.com") do |farmer|
    farmer.password = "password"
    farmer.password_confirmation = "password"
    farmer.first_name = "太郎#{i + 1}"
    farmer.last_name = "農家#{i + 1}"
    farmer.first_name_kana = "タロウ#{i + 1}"
    farmer.last_name_kana = "ノウカ#{i + 1}"
    farmer.postal_code = "123456#{(i % 10)}"
    farmer.seller_address = "東京都新宿区#{i + 1}丁目"
    farmer.prefecture = "東京都"
    farmer.introduction = "よろしくお願いします。#{i + 1}"
  end
end

20.times do |i|
  Customer.find_or_create_by!(email: "customer#{i + 1}@example.com") do |customer|
    customer.password = "password"
    customer.password_confirmation = "password"
    customer.first_name = "花子#{i + 1}"
    customer.last_name = "消費者#{i + 1}"
    customer.first_name_kana = "ハナコ#{i + 1}"
    customer.last_name_kana = "ショウヒシャ#{i + 1}"
    customer.telephone_number = "090123456#{format('%02d', i)}"
    customer.introduction = "よろしくお願いします。#{i + 1}"
  end
end