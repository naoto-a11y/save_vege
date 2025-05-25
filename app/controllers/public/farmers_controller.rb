class Public::FarmersController < ApplicationController
  def show
    @tags = Tag.all
    @farmer = Farmer.find(params[:id])
    @items_count = @farmer.items.active.count
    @followers_count = @farmer.followers.count
    @comment_items_count = Item.active.where(id: Comment.where(sender: @farmer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct).count
  
    case params[:filter]
    when "commented"
      @items = Item.active.where(id: Comment.where(sender: @farmer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct).page(params[:page]).per(8)
  
    else
      @items = @farmer.items.active.page(params[:page]).per(8)
    end
  end
end
