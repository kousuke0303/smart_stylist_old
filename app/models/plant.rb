class Plant < ApplicationRecord
  belongs_to :user
  
  before_save { self.email = email.downcase unless self.email.nil? }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :address , length: { maximum: 100 }
  validates :tel_1, length: { maximum: 20 }
  validates :tel_2, length: { maximum: 20 }
  validates :fax, length: { maximum: 20 }
  validates :email, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX },
                    allow_nil: true
  validates :staff_1, length: { maximum: 50 }
  validates :staff_2, length: { maximum: 50 }
  validates :note, length: { maximum: 300 }
end
