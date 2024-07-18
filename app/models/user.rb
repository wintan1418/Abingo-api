class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
         enum role: { customer: 0, merchant: 1, admin: 2 }

          has_many :orders
          has_many :coupons
          has_many :products, dependent: :destroy
          has_one :cart, dependent: :destroy
          after_create :create_initial_cart

  def first_time_user?
    orders.count == 0
  end

  def eligible_for_discount?
    orders.count >= 5
  end

  def jwt_payload
    { 'user_id' => self.id }
  end

  def create_cart_if_not_exists
    create_cart if cart.nil?
  end

  private

  def create_initial_cart
    create_cart # Create a cart for the user after creation
  end
end
