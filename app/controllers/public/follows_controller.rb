class Public::FollowsController < ApplicationController
  def index
    @customer = current_customer
    @follows = @customer.followed_farmers
  end

  def create
  end

  def destroy
  end
end
