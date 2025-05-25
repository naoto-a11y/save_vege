class Farmer::ReservationsController < ApplicationController
  before_action :authenticate_farmer!

  def index
    @items = current_farmer.items
    @items_count = current_farmer.items.count
    @farmer = current_farmer
    @reservations = current_farmer.reservations
    @items_upcoming_slots_count = @items.joins(:available_slots).group('items.id').having('MAX(available_slots.available_date) <= ?', 1.week.from_now).length
    @recent_items_count = @items.joins(:comments).where(comments: { sender_type: 'Customer' }).where('comments.created_at >= ?', 1.week.ago).distinct.count
    @favorites_items_count = @items.joins(:favorites).distinct.count
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
