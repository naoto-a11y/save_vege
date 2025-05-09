class Public::ReservationsController < ApplicationController
  def confirm
  end

  def thanks
  end

  def create
    reservation = current_customer.reservations.new(
      item_id: params[:item_id],
      pickup_date: params[:pickup_date]
    )
    if reservation.save
      redirect_to item_path(params[:item_id]), notice: "予約が完了しました"
    else
      redirect_to item_path(params[:item_id]), alert: "予約に失敗しました"
    end
  end

end
