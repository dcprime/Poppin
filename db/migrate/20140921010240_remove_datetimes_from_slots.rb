class RemoveDatetimesFromSlots < ActiveRecord::Migration
  def change
    remove_column :slots, :slot_start, :datetime
    remove_column :slots, :slot_end, :datetime
  end
end
