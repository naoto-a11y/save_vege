class Public::ReservationsController < ApplicationController
  def confirm
  end

  def thanks
  end

  def create
    @reservation = current_customer.reservations.new(
      item_id: params[:item_id],
      reserved_date: params[:reserved_date]
    )
    if @reservation.save
      DmRoom.create(reservation: @reservation)
      redirect_to item_path(params[:item_id]), notice: "予約が完了しました"
      
    else
      redirect_to item_path(params[:item_id]), alert: "予約に失敗しました"
    end
  end

end
