class Admin::HomesController < ApplicationController

  def top
    today = Time.zone.today
    start_of_week = 6.days.ago.beginning_of_day
    end_of_week = Time.current
    start_of_last_month = (today - 1.month).beginning_of_month
    end_of_last_month = (today - 1.month).end_of_month
  
    #今週の日別投稿数
    @item_counts_day = Item.where(created_at: start_of_week..end_of_week).group("DATE(CONVERT_TZ(created_at, '+00:00', '+09:00'))").count
  
    # 今週の日別ユーザー登録数　消費者
    @customer_counts_day = Customer.where(created_at: start_of_week..end_of_week).group("DATE(CONVERT_TZ(created_at, '+00:00', '+09:00'))").count
  
    # 今週の日別ユーザー登録数　農家
    @farmer_counts_day = Farmer.where(created_at: start_of_week..end_of_week).group("DATE(CONVERT_TZ(created_at, '+00:00', '+09:00'))").count
  
    # 先月の投稿数合計
    @last_month_item_total = Item.where(created_at: start_of_last_month..end_of_last_month).count
  
    # 先月の登録者数合計　消費者
    @last_month_customer_total = Customer.where(created_at: start_of_last_month..end_of_last_month).count
  
    # 先月の登録者数合計　農家
    @last_month_farmer_total = Farmer.where(created_at: start_of_last_month..end_of_last_month).count
  
    # 新着商品一覧（5件）
    @recent_items = Item.order(created_at: :desc).limit(5)
  end

end