class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  def apply_coupon(coupon_code)
    coupon = coupon.find_by(code: coupon_code)
    if coupon
      coupon.apply_to_order(self)
    end
  end
end
