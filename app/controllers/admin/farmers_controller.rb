class Admin::FarmersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
  end

  def show
  end

  def update
    @farmer = Farmer.find(params[:id])  
  
    if @farmer.update(farmer_params)
      redirect_to admin_customers_path, notice: "会員情報を更新しました"
    else
      redirect_to request.referer, alert: "更新に失敗しました"
    end
  end

  def edit
    @farmer = Farmer.find(params[:id])
  end

  private

  def farmer_params
    params.require(:farmer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :seller_address, :email, :status)
  end
end
