class ConversationsController < ApplicationController
    
    def index
        conversations = Conversation.all
        render json: conversations
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.save
            
            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serializable_hash

            ActionCable.server.broadcast 'conversations_channel', { action: 'post', data: serialized_data }  
            
            head :ok
        end        
    end

    def destroy
        conversation = Conversation.find(params[:id])
        if conversation.destroy
            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serializable_hash
            ActionCable.server.broadcast 'conversations_channel', { action: 'delete', data: serialized_data }
            head :ok
        end        
    end

    private
  
    def conversation_params
        params.require(:conversation).permit(:title, :id)
    end

end
