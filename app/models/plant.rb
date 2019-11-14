class Plant < ApplicationRecord
  belongs_to :user
  
  before_save { self.email = email.downcase unless self.email.nil? }
  before_save { self.tel_1 = NKF.nkf('-w -Z4', tel_1).delete("^0-9") }
  before_save { self.tel_2 = NKF.nkf('-w -Z4', tel_1).delete("^0-9") }
  before_save { self.fax = NKF.nkf('-w -Z4', tel_1).delete("^0-9") }
  before_save { self.zipcode = nil }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 100 }
  validates :tel_1, length: { maximum: 20 }
  validates :tel_2, length: { maximum: 20 }
  validates :fax, length: { maximum: 20 }
  validates :email, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX },
                    allow_blank: true
  validates :staff_1, length: { maximum: 50 }
  validates :staff_2, length: { maximum: 50 }
  validates :note, length: { maximum: 150 }
end
