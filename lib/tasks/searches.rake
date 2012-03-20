namespace :searches do

  task :reload => :environment do
    Search.monitored.find_in_batches batch_size: 25 do |searches|
      begin
        searches.each &:perform
      rescue Exception => e
        Airbrake.notify e
      end
    end
  end

  task :broken => :environment do
    Search.monitored.find_in_batches batch_size: 25 do |searches|
      begin
        searches.each &:perform
        raise "wtf"
      rescue Exception => e
        p "hi"
        Airbrake.notify e
      end
    end
  end

end
