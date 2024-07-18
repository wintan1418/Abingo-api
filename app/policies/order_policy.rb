# app/policies/order_policy.rb
class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all # Admins can see all orders
      else
        scope.where(user_id: user.id) # Regular users can see only their own orders
      end
    end
  end
  
  def index?
    true # Anyone can view the list of orders
  end
  
  def show?
    user.admin? || record.user == user # Admins or the order's owner can view an order
  end
  
  def create?
    true # Anyone can create an order (customize as needed)
  end
  
  def update?
    user.admin? || record.user == user # Admins or the order's owner can update an order
  end
  
  def destroy?
    user.admin? || record.user == user # Admins or the order's owner can delete an order
  end
end
