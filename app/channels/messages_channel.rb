class MessagesChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by_id(params[:conversation])
    if conversation
    	stream_for conversation
    end
  end

  def unsubscribed
    unsubscribe_from_all
  end
end
