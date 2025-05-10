class Farmer::FarmersController < ApplicationController
  def show
    @farmer = current_farmer
    @items = current_farmer.items
    @reservations = current_farmer.reservations
    @reservation_count = current_farmer.reservations.count
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
