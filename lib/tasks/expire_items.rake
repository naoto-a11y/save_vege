namespace :batch do
  desc "全ての商品の is_active をトグルする（true→false, false→true）"
  task toggle_items: :environment do
    Item.find_each do |item|
      item.toggle!(:is_active)
    end
    puts "[#{Time.now}] 全てのアイテムの is_active を反転させました"
  end
end