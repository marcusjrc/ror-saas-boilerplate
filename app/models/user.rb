# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :subscription, dependent: :destroy

  validates :timezone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 300 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 300 }

  after_save :assign_customer_id

  def full_name
    "#{first_name} #{last_name}"
  end

  def subscribed?
    !subscription.blank? && (subscription.status == 'active' || subscription.status == 'trialing') and subscription.current_period_end > Time.now
  end

  def subscription_name
    subscription.product.title
  end

  def assign_customer_id
    return unless customer_id.blank?

    customer = Stripe::Customer.create(email:, name: full_name)
    update(customer_id: customer.id)
  end
end
