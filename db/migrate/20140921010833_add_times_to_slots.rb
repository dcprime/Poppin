class AddTimesToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :day, :string
    add_column :slots, :start_time, :string
    add_column :slots, :end_time, :string
  end
end
