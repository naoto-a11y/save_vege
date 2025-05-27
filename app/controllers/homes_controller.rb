class HomesController < ApplicationController
  def top
    #受取日が過ぎていたら販売ステータスをfalseに
    Item.all.each { |item| item.deactivate_if_expired }
    @items = Item.active.page(params[:page]).per(8)
    @tags = Tag.all
    @categories = Category.all
    @areas = Farmer.distinct.pluck(:prefecture)
  end

  def about
  end
end
