class HistoryTradeSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :symbol, :created_at
end
