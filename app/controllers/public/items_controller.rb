class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @comments = @item.comments
    @tags = Tag.all
    @comment = Comment.new
    @reservation = @customer.reservation_for(@item)
  end
end
