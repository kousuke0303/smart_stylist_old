desc "This task is called by the Heroku scheduler add-on"
task :check_subscription_status => :environment do
  puts "Updating feed..."
end