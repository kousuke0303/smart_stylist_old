class Client < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  
  attr_accessor :zipcode
  before_save { self.email = email.downcase unless email.nil? }
  before_save { self.tel_1 = NKF.nkf('-w -Z4', tel_1).delete("^0-9") unless tel_1.blank? }
  before_save { self.tel_2 = NKF.nkf('-w -Z4', tel_2).delete("^0-9") unless tel_2.blank? }
  before_save { self.fax = NKF.nkf('-w -Z4', fax).delete("^0-9") unless fax.blank? }
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :kana, presence: true, length: { maximum: 30 }
  validates :tel_1, length: { maximum: 11 }, format: { with: VALID_TEL_REGEX }, allow_blank: true
  validates :tel_2, length: { maximum: 11 }, format: { with: VALID_TEL_REGEX }, allow_blank: true
  validates :fax, length: { maximum: 10 }, format: { with: VALID_FAX_REGEX }, allow_blank: true
  validates :address, length: { maximum: 50 }
  validates :work, length: { maximum: 20 }
  validates :email, length: { maximum: 254 }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :note, length: { maximum: 100 }
  
  validate :kana_rule
  
  def kana_rule
    errors.add(:kana, "は全角カタカナのみで入力して下さい") if self.kana.present? && !self.kana.match(/\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/)
  end
end
