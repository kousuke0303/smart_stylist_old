class Plant < ApplicationRecord
  belongs_to :user
  
  attr_accessor :zipcode
  before_save { self.email = email.downcase unless email.nil? }
  before_save { self.tel_1 = tel_1.delete("　") unless tel_1.nil? }
  before_save { self.tel_2 =  tel_2.delete("　") unless tel_2.nil? }
  before_save { self.fax =  fax.delete("　") unless fax.nil? }
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :address, length: { maximum: 50 }
  validates :tel_1, length: { maximum: 11 }, format: { with: VALID_TEL_REGEX }, allow_blank: true
  validates :tel_2, length: { maximum: 11 }, format: { with: VALID_TEL_REGEX }, allow_blank: true
  validates :fax, length: { maximum: 10 }, format: { with: VALID_FAX_REGEX }, allow_blank: true
  validates :email, length: { maximum: 254 }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :staff_1, length: { maximum: 30 }
  validates :staff_2, length: { maximum: 30 }
  validates :note, length: { maximum: 100 }
end
