desc "This task is called by the Heroku scheduler add-on"
task :check_subscription_status => :environment do
  Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  User.where(admin: false, pay_status: true).each do |user|
    ActiveRecord::Base.transaction do
      subscription = Payjp::Subscription.retrieve(user.subscription_id)
      user.update_attributes!(pay_status: false) if subscription.status == "paused" || subscription.status == "canceled"
    rescue
      user.update_attributes(pay_status: false)
    end
  end
end