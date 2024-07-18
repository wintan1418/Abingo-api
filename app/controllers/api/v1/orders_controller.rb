class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index

  # POST /api/v1/orders
  def create
    order = current_user.orders.new(order_params)
    authorize order
    if order.save
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/orders
  def index
    @orders = policy_scope(Order)
    render json: @orders, include: :order_items
  end

  # GET /api/v1/orders/:id
  def show
    @order = find_order
    authorize @order
    render json: @order, include: :order_items
  end

  # PATCH/PUT /api/v1/orders/:id
  def update
    @order = find_order
    authorize @order
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/:id
  def destroy
    @order = find_order
    authorize @order
    @order.destroy
    head :no_content
  end

  private

  def find_order
    current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:total_price, :status, :delivery_address, order_items_attributes: [:product_id, :quantity, :price])
  end
end
