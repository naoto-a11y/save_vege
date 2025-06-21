class HomesController < ApplicationController
  def top
    @items = Item.joins(:available_slots)
             .active
             .group('items.id')
             .having('MAX(available_slots.available_date) > ?', Date.today)
             .order(created_at: :desc)
             .page(params[:page])
             .per(8)
    @tags = Tag.all
    @categories = Category.all
    @areas = Farmer.distinct.pluck(:prefecture)
  end

  def about
  end
end
