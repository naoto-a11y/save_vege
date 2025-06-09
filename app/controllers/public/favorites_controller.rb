class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    @item = Item.find(params[:item_id])
    favorite = current_customer.favorites.new(item_id: params[:item_id])
    favorite.save
  end

  def destroy
    favorite = current_customer.favorites.find(params[:id])
    @item = favorite.item
    favorite.destroy
  end
end
