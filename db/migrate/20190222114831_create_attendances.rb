class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :user_id, index: true
      t.integer :event_id, index: true
      t.timestamps
    end
  end
end
