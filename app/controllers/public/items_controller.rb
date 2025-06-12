class Public::ItemsController < ApplicationController
 
  def index
    @categories = Category.all
    @areas = Farmer.distinct.pluck(:prefecture)
    @tags = Tag.all
  
    @items = Item.includes(:farmer).distinct.page(params[:page]).per(8)
  
    # カテゴリ
    if params[:category_ids].present?
      category_ids = params[:category_ids].map(&:to_i)
      @items = @items.where(category_id: category_ids).page(params[:page]).per(8)
    end
  
    # 地域
    if params[:prefecture].present?
      @items = @items.joins(:farmer).where(farmers: { prefecture: params[:prefecture] }).page(params[:page]).per(8)
    end
  
    # キーワード
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @items = @items.where("items.name LIKE :word", word: keyword).page(params[:page]).per(8)
    end

    if params[:tag_ids].present?
      tag_ids = Array(params[:tag_ids]).map(&:to_i)
      @items = @items.joins(:tags).where(tags: { id: tag_ids }).distinct.page(params[:page]).per(8)
    end
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @comments = @item.comments
    @tags = Tag.all
    @comment = Comment.new
    @reservation = Reservation.new
    if customer_signed_in?
      @reservation = current_customer.reservation_for(@item)
    end
  end
end
