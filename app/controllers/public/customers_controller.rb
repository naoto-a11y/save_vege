class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :edit, :update, :withdraw, :unsubscribe]

  def show
    #受取日が過ぎていたら販売ステータスをfalseに
    Item.all.each { |item| item.deactivate_if_expired }
    @customer = current_customer
    @items_count = current_customer.favorite_items.active.count
    @items = current_customer.favorite_items.active.page(params[:page]).per(8)
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true }, status: :in_progress).page(params[:page]).per(8)
    @following_farmers = current_customer.followed_farmers.where(status: true)
    @recent_items_count = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct).count

    @filtered_items = case params[:filter]
    when "commented"
      @items = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct).page(params[:page]).per(8)
    when "liked"
      @items = current_customer.favorite_items.active.page(params[:page]).per(8)
    else
      @items = current_customer.favorite_items.active.page(params[:page]).per(8)
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to customers_information_edit_path
    else
      render :edit
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

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :profile_image )
  end
end
