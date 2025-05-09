class Public::FarmersController < ApplicationController
  def show
    @tags = Tag.all
    @farmer = Farmer.find(params[:id])
    @items = @farmer.items
  end
end
