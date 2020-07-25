class Plant < ApplicationRecord
  belongs_to :user
  
  before_save { self.address = nil if !address.nil? && address.match(ONLY_SPACE_REGEX) }
  before_save { self.tel_1 = nil if !tel_1.nil? && tel_1.match(ONLY_SPACE_REGEX) }
  before_save { self.tel_2 = nil if !tel_2.nil? && tel_2.match(ONLY_SPACE_REGEX) }
  before_save { self.fax = nil if !fax.nil? && fax.match(ONLY_SPACE_REGEX) }
  before_save { self.email = email.downcase unless email.nil? }
  before_save { self.email = nil if !email.nil? && email.match(ONLY_SPACE_REGEX) }
  before_save { self.staff_1 = nil if !staff_1.nil? && staff_1.match(ONLY_SPACE_REGEX) }
  before_save { self.staff_2 = nil if !staff_2.nil? && staff_2.match(ONLY_SPACE_REGEX) }
  before_save { self.note = nil if !note.nil? && note.match(ONLY_SPACE_REGEX) }
  
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
