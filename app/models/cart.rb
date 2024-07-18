class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product, quantity)
    existing_item = cart_items.find_by(product_id: product.id)

    if existing_item
      existing_item.update(quantity: existing_item.quantity + quantity)
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def total_price
    cart_items.map { |item| item.quantity * item.product.price }.sum
  end
end
