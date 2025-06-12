class Farmer::CommentsController < ApplicationController
  before_action :authenticate_farmer!

  def create
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    @comment = @item.comments.new(comment_params)
    @comment.sender = current_farmer
    @comment.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    @comment = @item.comments.find(params[:id])
  
    if @comment.sender == current_farmer || @item.farmer == current_farmer
      @comment.destroy
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
