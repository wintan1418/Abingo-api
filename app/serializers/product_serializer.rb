class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url
  def merchant_email
    object.user.email
  end

  def order_count
    object.orders.count
  end
end
