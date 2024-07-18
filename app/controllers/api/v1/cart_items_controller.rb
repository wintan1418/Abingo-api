# app/controllers/api/v1/cart_items_controller.rb
class Api::V1::CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if current_user.cart.add_product(product, quantity)
      render json: { message: "Product added to cart successfully", cart: current_user.cart }, status: :created
    else
      render json: { error: "Failed to add product to cart" }, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])

    if cart_item.destroy
      render json: { message: "Cart item removed successfully", cart: current_user.cart }, status: :ok
    else
      render json: { error: "Failed to remove cart item" }, status: :unprocessable_entity
    end
  end
end
