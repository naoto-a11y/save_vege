class HomesController < ApplicationController
  def top
    @items = Item.all
    @tags = Tag.all
  end

  def about
  end
end
