class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :edit, :update, :withdraw, :unsubscribe]

  def show
    @customer = current_customer
    @items = current_customer.favorite_items.active
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    @following_farmers = current_customer.followed_farmers
    @recent_items = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct)
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

  def recent_commented_items
    @customer = current_customer
    @items = current_customer.favorite_items.active
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    @following_farmers = current_customer.followed_farmers
    @recent_items = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct)
  end
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :profile_image )
  end
end
