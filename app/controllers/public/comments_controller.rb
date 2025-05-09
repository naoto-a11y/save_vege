class Public::CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    @comment.sender = current_customer || current_farmer
    if @comment.save
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
