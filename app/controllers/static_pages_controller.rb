class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :top
  before_action :only_pay_status_true, only: :top
  
  def top
  end
  
  def agree_to_terms
  end
  
  def terms_of_service
  end
  
  def privacy_policy
  end
end