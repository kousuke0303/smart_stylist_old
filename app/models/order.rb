class Order < ApplicationRecord
  belongs_to :client
  include OrdersHelper
  
  before_save { total_unpaid(self) > 0 ? self.unpaid = true : self.unpaid = false }
  before_save { self.narrow = nil }
  
  validates :client_id, presence: true
  validates :kind, presence: true
  validates :order_date, presence: true
  validates :retail, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :wage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :cloth, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :lining, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :button, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :postage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :other, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :note, length: { maximum: 150 }
  validates :user_id, presence: true
  
  validate :order_date_than_sales_date_fast_if_invalid
  validate :order_date_than_delivery_fast_if_invalid
  validate :invalid_pay_without_cost
  
  def order_date_than_sales_date_fast_if_invalid
    unless sales_date.blank?
      errors.add(:order_date, "より早い売上日は無効です。") if order_date > sales_date
    end
  end
  
  def order_date_than_delivery_fast_if_invalid
    unless delivery.blank?
      errors.add(:order_date, "より早い納品予定日は無効です。") if order_date > delivery
    end
  end
  
  def invalid_pay_without_cost
    errors.add(:wage, "の金額を入力してください。") if wage.nil? && wage_pay.present?
    errors.add(:cloth, "の金額を入力してください。") if cloth.nil? && cloth_pay.present?
    errors.add(:lining, "の金額を入力してください。") if lining.nil? && lining_pay.present?
    errors.add(:button, "の金額を入力してください。") if button.nil? && button_pay.present?
    errors.add(:postage, "の金額を入力してください。") if postage.nil? && postage_pay.present?
    errors.add(:other, "の金額を入力してください。") if other.nil? && other_pay.present?
  end
end
