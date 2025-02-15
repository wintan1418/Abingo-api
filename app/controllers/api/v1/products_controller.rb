# app/controllers/api/v1/products_controller.rb
class Api::V1::ProductsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      before_action :set_product, only: [:show, :update, :destroy, :approve, :decline]
      before_action :authorize_merchant!, only: [:create, :update, :destroy]
      before_action :authorize_admin!, only: [:approve, :decline]

      def index
        products = Product.ransack(params[:q]).result.page(params[:page]).per(10)
        render json: products
      end

      def show
        render json: @product
      end

      def create
        @product = current_user.products.build(product_params)
        if @product.save
          render json: @product
        else
          render json: { errors: @product.errors.full_messages }, status: 422
        end
      end

      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: { errors: @product.errors.full_messages }, status: 422
        end
      end

      def destroy
        @product.destroy
        head :no_content
      end

      def approve
        @product.update(approved: true)
        render json: @product
      end

      def decline
        @product.destroy
        head :no_content
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :price, :description, :image_url)
      end

      def authorize_merchant!
        unless current_user.merchant?
          render json: { error: 'Not authorized' }, status: :forbidden
        end
      end

      def authorize_admin!
        unless current_user.admin?
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
  end
  
