class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.text :description
      t.integer :room_id
      t.integer :host_id
      t.datetime :schedule

      t.timestamps null: false
    end

    add_index :lessons, :room_id
    add_index :lessons, :host_id
  end
end
