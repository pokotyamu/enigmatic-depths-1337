require "#{Rails.root}/app/models/counter"

class Cron::SampleBatch
  def self.execute
    test = Counter.all
    
    test.each do |t|
      p t.sleepcount
    end
    
  end
end
