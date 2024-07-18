class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :status
  has_many :order_items
end
