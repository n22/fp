class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_action :verify_authenticity_token
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    @path = conversation_path(@conversation)
    format.html {redirect_to root_url}
    format.js
  end

  private

  def message_params
    params.require(:message).permit(:body, :image)
  end
end