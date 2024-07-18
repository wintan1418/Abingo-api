class CouponsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    coupon = Coupon.new(coupon_params)
    authorize coupon
    if coupon.save
      render json: coupon, status: :created
    else
      render json: coupon.errors, status: :unprocessable_entity
    end
  end

  def update
    coupon = Coupon.find(params[:id])
    authorize coupon
    if coupon.update(coupon_params)
      render json: coupon
    else
      render json: coupon.errors, status: :unprocessable_entity
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :expiry_date, :usage_count, :user_id)
  end
end