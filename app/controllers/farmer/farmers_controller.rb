class Farmer::FarmersController < ApplicationController
  before_action :authenticate_farmer!
  def show
    @farmer = current_farmer
    @items = current_farmer.items
    @items_count = current_farmer.items.count
    @reservations = current_farmer.reservations
    @items_upcoming_slots_count = @items.joins(:available_slots).group('items.id').having('MAX(available_slots.available_date) <= ?', 1.week.from_now).length
    @recent_items_count = @items.joins(:comments).where(comments: { sender_type: 'Customer' }).where('comments.created_at >= ?', 1.week.ago).distinct.count
    @favorites_items_count = @items.joins(:favorites).distinct.count

    @filtered_items = case params[:filter]
    when "upcoming"
      @items = @items.joins(:available_slots).group('items.id').having('MAX(available_slots.available_date) <= ?', 1.week.from_now).page(params[:page]).per(8)
    when "commented"
      @items = @items.joins(:comments).where(comments: { sender_type: 'Customer' }).where('comments.created_at >= ?', 1.week.ago).distinct.page(params[:page]).per(8)
    when "liked"
      @items = @items.joins(:favorites).distinct.page(params[:page]).per(8)
    else
      @items = current_farmer.items.page(params[:page]).per(8)
    end
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
    params.require(:farmer).permit(:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :seller_address, :postal_code, :prefecture )
  end
  
end
