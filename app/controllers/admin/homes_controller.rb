class Admin::HomesController < ApplicationController

  def top
    @recent_items = Item.order(created_at: :desc).limit(10)
  end

end