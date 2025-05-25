class Farmer::ItemsController < ApplicationController
  before_action :authenticate_farmer!

  def new
    @item = Item.new
    3.times { @item.available_slots.build }
  end

  def create
    @item = Item.new(item_params.except(:tag_names))
    @item.farmer_id = current_farmer.id
    tag_list = params[:item][:tag_names].split(',')
    if @item.save
      @item.save_tags(tag_list)
      redirect_to farmer_farmers_mypage_path
    else
      render :new
    end
      
  end

  def show
    @farmer = current_farmer
    @tags = Tag.all
    @item = Item.find(params[:id])
    @comments = @item.comments
    @comment = Comment.new
    @reservation_count = current_farmer.reservations.count
  end

  def edit
    @item = Item.find(params[:id])
    (3 - @item.available_slots.size).times { @item.available_slots.build }
  end

  def update
    @item = current_farmer.items.find(params[:id])
    tag_names = []
    if @item.update(item_params)
      # ① チェックされた既存タグの名前を取得
      if params[:item][:tag_ids].present?
        existing_tag_ids = params[:item][:tag_ids].reject(&:blank?)
        existing_tags = Tag.where(id: existing_tag_ids)
        tag_names += existing_tags.pluck(:tag_name)
      end
      # ② カンマ区切りの新規タグ名を追加
      if params[:item][:tag_names].present?
        new_names = params[:item][:tag_names].split(",").map(&:strip).reject(&:blank?)
        tag_names += new_names
      end
      # 重複を除く
      tag_names.uniq!
      @item.save_tags(tag_names)
      redirect_to farmer_item_path(@item), notice: "商品情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = "商品を削除しました。"
      redirect_to farmer_farmers_mypage_path
    end
  end

  def deactivate
    @item = Item.find(params[:id])
    if @item.update(is_active: false)
      flash[:notice] = "商品を非公開にしました"
    else
      flash[:alert] = "非公開にできませんでした"
    end
    redirect_to farmer_item_path(@item)
  end

  def activate
    @item = Item.find(params[:id])
    if @item.update(is_active: true)
      flash[:notice] = "商品を公開しました"
    else
      flash[:alert] = "商品を公開にできませんでした"
    end
    redirect_to farmer_item_path(@item)
  end

  private
  def item_params
    params.require(:item).permit(
    :name, :image, :price, :introduction, :harvest_date, :tag_names, 
    :category_id, available_slots_attributes: [:available_date, :id, :_destroy], tag_ids: []
  )
  end
end
