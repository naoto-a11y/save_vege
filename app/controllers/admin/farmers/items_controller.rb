class Admin::Farmers::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @farmer = Farmer.find(params[:farmer_id])
    @items = @farmer.items.page(params[:page]).per(10)
  end

  def show
    @farmer = Farmer.find(params[:farmer_id])
    @item = Item.find(params[:id])
    @comments = @item.comments
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
  
    if params[:item] # 編集フォームからの更新の場合
      if @item.update(item_params)
        redirect_to admin_farmer_item_path(@farmer, @item), notice: "商品情報を更新しました"
      else
        render :edit
      end
    else # 公開/非公開切り替えの場合（ボタンなど）
      if @item.is_active == true
        @item.update(is_active: false)
        redirect_to request.referer, notice: "商品情報を非公開にしました"
      else
        @item.update(is_active: true)
        redirect_to request.referer, notice: "商品情報を公開しました"
      end
    end
  end

  def edit
    @farmer = Farmer.find(params[:farmer_id])
    @item = @farmer.items.find(params[:id])
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :price, :introduction, :harvest_date, :is_active, :category_id, tag_ids: [], available_slots_attributes: [:available_date, :id])
  end

end
