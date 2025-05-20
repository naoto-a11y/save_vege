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
    @farmer = current_farmer
    if @farmer.update(farmer_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to farmer_farmers_mypage_path
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :show
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(status: false)
    reset_session
    flash[:notice] = "退会手続きが完了しました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def farmer_params
    params.require(:farmer).permit(:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :seller_address, :postal_code )
  end
  
end
