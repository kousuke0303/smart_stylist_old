class Order < ApplicationRecord
  belongs_to :client
  
  validates :kind, presence: true
  validates :order_date, presence: true
  validates :retail, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :wage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :cloth, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :lining, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :button, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :postage, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :other, numericality: { only_integer: true, greater_than: 0, less_than: 100_000_000 }
  validates :note, length: { maximum: 150 }
end
