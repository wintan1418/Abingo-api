class Coupon < ApplicationRecord
  belongs_to :user, optional: true

  scope :active, -> { where('expiry_date >= ?', Time.now)}

  def self.generate_for(user)
   if user.first_time_user?
     create(code: "FIRST#{SecureRandom.hex(4)}", discount: 10, expiry_date: 1.month.from_now, user: user)
   elsif user.eligible_for_discount?
    create(code: "FIVE#{SecureRandom.hex(4)}", discount: 15, expiry_date: 1.month.from_now, user: user)
   end
  end

  def apply_to_order(order)
    if active? && order.total_price.present?
      discount_amount = (order.total_price * (discount/ 100.0)).round(2)
      order.update(total_price: order.total_price - discount_amount)
    end
  end

  def active?
    expiry_date >= Time.now
  end
end
