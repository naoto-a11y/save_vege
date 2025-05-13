class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    @favorite_items = current_customer.favorite_items
    @reservations = current_customer.reservations
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
  end

  def cancel_reservation
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :profile_image )
  end
end
