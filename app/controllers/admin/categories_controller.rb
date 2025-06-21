class Admin::CategoriesController < ApplicationController
  def index
    @new_category = Category.new
    @categories = Category.all.page(params[:page]).per(10)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'カテゴリを作成しました'
    else
      flash[:alert] = @category.errors.full_messages.join("、")
      @categories = Category.all.page(params[:page]).per(10)
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'カテゴリを更新しました'
    else
      flash[:alert] = @category.errors.full_messages.join("、")
      @categories = Category.all.page(params[:page])
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: 'カテゴリを削除しました'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
