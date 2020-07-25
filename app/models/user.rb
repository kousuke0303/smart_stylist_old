class User < ApplicationRecord
  has_many :plants, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  attr_accessor :remember_token
  attr_accessor :number
  attr_accessor :cvc
  attr_accessor :exp_year
  attr_accessor :exp_month
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 254 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :question, presence: true
  validates :answer, presence: true, length: { maximum: 20 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 12 }, allow_nil: true
  validate :reject_space_in_answer
  
  def reject_space_in_answer
    if self.answer.present?
      errors.add(:answer, "に空白は使用出来ません") if self.answer.include?(" ") || self.answer.include?("　")
    end
  end
  
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
end
