class Farmer::CommentsController < ApplicationController
  before_action :authenticate_farmer!

  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    @comment.sender = current_farmer
    if @comment.save
      redirect_to farmer_item_path(@item), notice: "コメントを投稿しました"
    else
      flash[:alert] = @comment.errors.full_messages.join("、")
      redirect_to farmer_item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
  
    if @comment.sender == current_farmer || @item.farmer == current_farmer
      @comment.destroy
      redirect_to farmer_item_path(@item), notice: "コメントを削除しました"
    else
      redirect_to farmer_item_path(@item), alert: "コメント削除に失敗しました"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
