class Public::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @items = current_customer.favorite_items.active
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    @following_farmers = current_customer.followed_farmers
    @recent_items = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct)
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
