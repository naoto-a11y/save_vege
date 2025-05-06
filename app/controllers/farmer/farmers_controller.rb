class Farmer::FarmersController < ApplicationController
  def show
    @farmer = current_farmer
    @items = current_farmer.items
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  def cancel_reservation
  end
end
