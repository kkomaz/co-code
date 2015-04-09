class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :language_problem_id
      t.integer :host_id
      t.timestamps null: false
    end
  end
end
