class Admin::HomesController < ApplicationController

  def top
    # 新着商品一覧（5件）
    @recent_items = Item.order(created_at: :desc).limit(10)
  end

end