class Public::FollowsController < ApplicationController
  def index
    @customer = current_customer
    @follows = @customer.followed_farmers
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
