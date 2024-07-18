# app/policies/coupon_policy.rb
class CouponPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all # Admins can see all coupons
      else
        scope.where(user_id: user.id) # Regular users can see only their own coupons
      end
    end
  end
  
  def index?
    true # Anyone can view the list of coupons
  end
  
  def show?
    user.admin? || record.user == user # Admins or the coupon's owner can view a coupon
  end
  
  def create?
    true # Anyone can create a coupon (customize as needed)
  end
  
  def update?
    user.admin? # Only admins can update a coupon
  end
  
  def destroy?
    user.admin? # Only admins can delete a coupon
  end
end
