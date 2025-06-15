class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    @comment = @item.comments.new(comment_params)
    @comment.sender = current_customer
    @comment.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    @comment = @item.comments.find(params[:id])

    if @comment.sender == current_customer
      @comment.destroy
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
