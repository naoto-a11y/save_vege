class Farmer::ReservationsController < ApplicationController

  def index
    @farmer = current_farmer
    @reservations = current_farmer.reservations
    @reservation_count = current_farmer.reservations.count
  end
end
