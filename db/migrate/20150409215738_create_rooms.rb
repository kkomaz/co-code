class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :language_problem_id
      t.integer :host_id
      t.timestamps null: false
    end

    add_index :rooms, :language_problem_id
    add_index :rooms, :host_id
  end
end
