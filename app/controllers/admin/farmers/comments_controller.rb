class Admin::Farmers::CommentsController < ApplicationController

  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    @item = @farmer.items.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
    @comment.destroy
    redirect_to admin_farmer_item_path(@farmer, @item), notice: "コメントを削除しました"
  end
end
