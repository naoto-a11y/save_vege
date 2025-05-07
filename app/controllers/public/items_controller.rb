class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @comments = @item.comments
  end
end
