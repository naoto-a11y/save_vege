class HomesController < ApplicationController
  def top
    @items = Item.active
    @tags = Tag.all
  end

  def about
  end
end
