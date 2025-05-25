class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:customer_page]).per(10)
    @farmers = Farmer.page(params[:farmer_page]).per(10)
  end

  def show
  end

  def update
    @customer = Customer.find(params[:id])  
  
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "会員情報を更新しました"
    else
      redirect_to request.referer, alert: "更新に失敗しました"
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :email,:status)
  end
end
