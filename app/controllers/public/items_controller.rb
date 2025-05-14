class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @comments = @item.comments
    @tags = Tag.all
    @comment = Comment.new
    if customer_signed_in?
      @reservation = current_customer.reservation_for(@item)
      @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    end
  end
end
