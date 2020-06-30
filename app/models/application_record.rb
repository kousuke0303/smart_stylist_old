class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'nkf'
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_TEL_REGEX = /\A\d{10,11}\z/i
  VALID_FAX_REGEX = /\A\d{10}\z/i
end
