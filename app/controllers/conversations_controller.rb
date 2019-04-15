class ConversationsController < ApplicationController
    
    def index
        conversations = Conversation.all
        render json: conversations
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.save
            ActionCable.server.broadcast 'conversations_channel', action: 'post', conversation: conversation
            head :ok
        end        
    end

    def destroy
        
        conversation = Conversation.find_by_id(params[:id])
        
        if conversation
            conversation.destroy
        else
            conversation = {
                id: params[:id]
            }            
        end

        ActionCable.server.broadcast 'conversations_channel', action: 'delete', conversation: conversation

        head :ok       
    end

    private
  
    def conversation_params
        params.require(:conversation).permit(:title, :user_id)
    end

end
