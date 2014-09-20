class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :invite_id
      t.string :time_zone
      t.timestamps
    end
  end
end
