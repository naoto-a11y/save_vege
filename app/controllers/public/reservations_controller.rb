class Public::ReservationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @items_count = current_customer.favorite_items.active.count
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    @following_farmers = current_customer.followed_farmers
    @recent_items_count = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct).count
  end

  def confirm
  end

  def thanks
  end

  def create
    @item = Item.find(params[:item_id])
    @reservation = current_customer.reservations.new(
      item_id: params[:item_id],
      reserved_date: params[:reserved_date]
    )
    if @reservation.save
      DmRoom.create(reservation: @reservation)
      redirect_to item_path(@item), notice: "予約が完了しました"
    else 
      flash[:alert] = @reservation.errors.full_messages.join("、")
      redirect_to item_path(@item)
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
