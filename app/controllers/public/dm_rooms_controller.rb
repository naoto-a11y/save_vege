class Public::DmRoomsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @dm_room = DmRoom.find(params[:id])
    @dm_messages = @dm_room.dm_messages.includes(:sender).order(:created_at)
  end
end
