class Farmer::FarmersController < ApplicationController
  before_action :authenticate_farmer!
  def show
    @farmer = current_farmer
    @items = current_farmer.items
    @reservations = current_farmer.reservations
    @reservation_count = current_farmer.reservations.count
  end

  def edit
    @farmer = current_farmer
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(status: false)
    reset_session
    flash[:notice] = "退会手続きが完了しました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
end
