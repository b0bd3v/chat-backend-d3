class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title :created_at
  has_many :messages
end
