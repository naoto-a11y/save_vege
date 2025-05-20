class Admin::Farmers::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @farmer = Farmer.find(params[:farmer_id])
    @items = @farmer.items.page(params[:page]).per(10)
  end

  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    item = @farmer.items.find(params[:id])
    item.destroy
    redirect_to admin_farmer_items_path(@farmer), notice: "商品を削除しました"
  end

  def update
    @farmer = Farmer.find(params[:farmer_id])
    @item = @farmer.items.find(params[:id])
  
    if @item.is_active == true
      @item.update(is_active: false)
      redirect_to admin_farmer_items_path(@farmer), notice: "商品情報を非公開にしました"
    else
      @item.update(is_active: true)
      redirect_to admin_farmer_items_path(@farmer), notice: "商品情報を公開しました"
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:is_active)
  end

end
