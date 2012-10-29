namespace :users do

  task :clean => :environment do
    User.includes(:searches).where("users.created_at < ?", 14.days.ago).find_in_batches do |users|
      users.each do |user|
        if user.searches.count == 0
          puts "removing: #{user.inspect}"
          user.destroy
        end
      end
    end
  end

end
