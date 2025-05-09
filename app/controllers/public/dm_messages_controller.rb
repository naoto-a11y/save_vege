class Public::DmMessagesController < ApplicationController

  def create
    @dm_room = DmRoom.find(params[:dm_room_id])
    @dm_message = @dm_room.dm_messages.new(dm_message_params)
    @dm_message.sender = current_customer || current_farmer

    if @dm_message.save
      redirect_to dm_room_path(@dm_room), notice: "メッセージを送信しました"
    else
      @dm_messages = @dm_room.dm_messages.includes(:sender).order(:created_at)
      flash.now[:alert] = "メッセージの送信に失敗しました"
      render "public/dm_rooms/show"
    end
  end

  def destroy
  end

  private

  def dm_message_params
    params.require(:dm_message).permit(:message)
  end
end
