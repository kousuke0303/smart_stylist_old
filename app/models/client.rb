class Client < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  
  attr_accessor :zipcode
  before_save { self.email = email.downcase unless email.nil? }
  before_save { self.tel_1 = NKF.nkf('-w -Z4', tel_1).delete("^0-9") unless tel_1.blank? }
  before_save { self.tel_2 = NKF.nkf('-w -Z4', tel_2).delete("^0-9") unless tel_2.blank? }
  before_save { self.fax = NKF.nkf('-w -Z4', fax).delete("^0-9") unless fax.blank? }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :kana, length: { maximum: 50 }
  validates :tel_1, length: { maximum: 20 }
  validates :tel_2, length: { maximum: 20 }
  validates :fax, length: { maximum: 20 }
  validates :address, length: { maximum: 100 }
  validates :work, length: { maximum: 50 }
  validates :email, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX },
                    allow_blank: true
  validates :note, length: { maximum: 150 }
end
