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
    if @item.update(item_params)
      # 新しいタグが入力されていたら追加
      if params[:item][:new_tag_names].present?
        new_tag_names = params[:item][:new_tag_names].split(',').map(&:strip).reject(&:blank?)
        new_tag_names.each do |name|
          tag = Tag.find_or_create_by(tag_name: name)
          unless @item.tags.include?(tag)
            @item.tags << tag 
          end
        end
      end
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

  private
  def item_params
    params.require(:item).permit(
    :name, :image, :price, :introduction, :harvest_date, :tag_names,
    available_slots_attributes: [:available_date, :id, :_destroy]
  )
  end
end
