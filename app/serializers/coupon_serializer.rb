class CouponSerializer < ActiveModel::Serializer
  attributes :id, :code, :discount, :expiry_date, :usage_count
end
