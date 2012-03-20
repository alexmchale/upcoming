namespace :searches do

  task :reload => :environment do
    begin
      Search.monitored.find_in_batches batch_size: 25 do |searches|
        searches.each &:perform
      end
    rescue Exception => e
      Airbrake.notify e
    end
  end

end
