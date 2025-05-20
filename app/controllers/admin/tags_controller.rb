class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.order(:tag_name).page(params[:page]).per(10)
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path, notice: "タグ「#{@tag.tag_name}」を削除しました。"
  end

end
