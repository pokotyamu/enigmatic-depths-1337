class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :sleepcount
      t.datetime :twitime

      t.timestamps
    end
  end
end
