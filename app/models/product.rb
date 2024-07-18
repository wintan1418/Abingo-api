class Product < ApplicationRecord
  # Associations
  belongs_to :user # Assuming products belong to a user (merchant)
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  # Enums for approval status
  # enum status: { pending: 0, approved: 1, declined: 2 }

  # Scopes
  # scope :pending_approval, -> { where(status: :pending) }
  # scope :approved, -> { where(status: :approved) }

  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true
end
