class Public::FollowsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @following_farmers = @customer.followed_farmers
    @items = current_customer.favorite_items.active
    @reservations = current_customer.reservations.joins(:item).where(items: { is_active: true })
    @recent_items = Item.active.where(id: Comment.where(sender: current_customer).where("created_at >= ?", 1.week.ago).select(:item_id).distinct)
  end

  def create
    farmer = Farmer.find(params[:farmer_id])
    current_customer.follows.create(farmer_id: farmer.id)
    redirect_to request.referer
  end

  def destroy
    farmer = Farmer.find(params[:farmer_id])
    follow = current_customer.follows.find_by(farmer_id: farmer.id)
    follow.destroy
    redirect_to request.referer
  end
end
