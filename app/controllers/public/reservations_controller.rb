class Public::ReservationsController < ApplicationController

  def index
    @customer = current_customer
    @reservations = @customer.reservations
  end

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

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to reservations_path, notice: "予約をキャンセルしました。"
    else
      flash[:notice] = "キャンセルできませんでした"
      redirect_to reservations_path
    end
  end

end
