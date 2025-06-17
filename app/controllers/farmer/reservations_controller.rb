class Farmer::ReservationsController < ApplicationController
  before_action :authenticate_farmer!

  def index
    #受取日が過ぎていたら販売ステータスをfalseに
    current_farmer.items.each { |item| item.deactivate_if_expired }
    @items = current_farmer.items
    @items_count = current_farmer.items.count
    @farmer = current_farmer
    @reservations = current_farmer.reservations.where(status: :in_progress).page(params[:page]).per(8)
    @items_upcoming_slots_count = @items.joins(:available_slots).group('items.id').having('MAX(available_slots.available_date) <= ?', 1.week.from_now).length
    @recent_items_count = @items.joins(:comments).where(comments: { sender_type: 'Customer' }).where('comments.created_at >= ?', 1.week.ago).distinct.count
    @favorites_items_count = @items.joins(:favorites).distinct.count
  end

  def cancel
    @reservation = Reservation.find(params[:id])
    if @reservation.update(status: :canceled, cancellation_reason: params[:reservation][:cancellation_reason])
      redirect_to farmer_reservations_path, notice: "予約をキャンセルしました"
    end
  end

  def complete
    reservation = Reservation.find(params[:id])
    if reservation.update(status: :completed)
      redirect_to farmer_reservations_path, notice: '受け取りが完了しました。'
    end
  end

  def history
    @items = current_farmer.items
    @items_count = current_farmer.items.count
    @farmer = current_farmer
    @reservations = current_farmer.reservations.where(status: :in_progress)
    @items_upcoming_slots_count = @items.joins(:available_slots).group('items.id').having('MAX(available_slots.available_date) <= ?', 1.week.from_now).length
    @recent_items_count = @items.joins(:comments).where(comments: { sender_type: 'Customer' }).where('comments.created_at >= ?', 1.week.ago).distinct.count
    @favorites_items_count = @items.joins(:favorites).distinct.count
    @reservations_index = current_farmer.reservations.includes(:item).order(created_at: :desc).page(params[:page]).per(8)
  end
  
end
