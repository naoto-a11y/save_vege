class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    @comment.sender = current_customer
    if @comment.save
      if current_customer
        redirect_to item_path(@item), notice: "コメントを投稿しました"
      else
        redirect_to farmer_item_path(@item), notice: "コメントを投稿しました"
      end
    else
      if current_customer
        redirect_to item_path(@item), alert: "コメント投稿に失敗しました"
      else
        redirect_to farmer_item_path(@item), alert: "コメント投稿に失敗しました"
      end
    end

  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])

    if @comment.sender == current_customer
      @comment.destroy
      redirect_to item_path(@item), notice: "コメントを削除しました"
    else
      redirect_to item_path(@item), alert: "削除権限がありません"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
