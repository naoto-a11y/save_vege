class Farmer::ReservationsController < ApplicationController

  def index
    @farmer = current_farmer
    @reservations = current_farmer.reservations
    @reservation_count = current_farmer.reservations.count
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to farmer_reservations_path, notice: "予約をキャンセルしました。"
    else
      flash[:notice] = "キャンセルできませんでした"
      redirect_to farmer_reservations_path
    end
  end
end
