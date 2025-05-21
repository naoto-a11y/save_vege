class HomesController < ApplicationController
  def top
    @items = Item.active
    @tags = Tag.all
    @categories = Category.all
    @areas = Farmer.distinct.pluck(:prefecture)
  end

  def about
  end
end
