class ChatSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_deleted
end
