class Farmer::ItemsController < ApplicationController
  def new
    @item = Item.new
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :price, :introduction, :available_date, :harvest_date, :tag_names)
  end
end
