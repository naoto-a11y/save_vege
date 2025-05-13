class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all

    if params[:tag_ids].present?
      tag_ids = params[:tag_ids].map(&:to_i)

      @items = Item.joins(:tags).where(tags: { id: tag_ids }).group("items.id").having("COUNT(DISTINCT tags.id) = ?", tag_ids.size)
    else
      @items = Item.all
      render "homes/top"
    end
  end
end
