class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    favorite = current_customer.favorites.new(item_id: params[:item_id])
    favorite.save
    redirect_to request.referer
  end

  def destroy
    favorite = current_customer.favorites.find(params[:id])
    favorite.destroy
    redirect_to request.referer
  end
end
