desc "Reload monitored searches and send emails about new records"
task :search => :environment do
  begin
    User.find_in_batches batch_size: 25 do |users|
      users.each do |user|
        user.search_and_notify
      end
    end
  rescue Exception => e
    p e
    puts e.message
    puts e.backtrace.join("\n")
    Airbrake.notify e
  end
end
