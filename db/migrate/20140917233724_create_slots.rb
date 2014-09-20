class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :label
      t.datetime :slot_start
      t.datetime :slot_end
      t.timestamps
    end
  end
end
