class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price
  belongs_to :product
end
