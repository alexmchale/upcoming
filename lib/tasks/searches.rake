namespace :searches do

  desc "Reload monitored searches and send emails about new records"
  task :reload => :environment do
    begin
      Search.monitored.find_in_batches batch_size: 25 do |searches|
        searches.each &:perform
      end
    rescue Exception => e
      Airbrake.notify e
    end
  end

  desc "Reload all searches and do not distribute emails"
  task :quietly => :environment do
    begin
      first_count = Record.count
      Search.find_in_batches batch_size: 25 do |searches|
        searches.each do |search|
          search.perform false
        end
      end
      final_count = Record.count
      records_added = final_count - first_count
      puts "#{records_added} records added"
    rescue Exception => e
      p e
      Airbrake.notify e
    end
  end

end
