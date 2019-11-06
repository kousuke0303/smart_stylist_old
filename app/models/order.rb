class Order < ApplicationRecord
  belongs_to :client
  
  validates :kind, presence: true
  validates :order_date, presence: true
  validates :retail, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :wage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :cloth, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :lining, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :button, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :postage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :other, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }, allow_blank: true
  validates :note, length: { maximum: 150 }
end
