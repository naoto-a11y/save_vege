class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    @items = current_customer.favorite_items
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  def cancel_reservation
  end
end
