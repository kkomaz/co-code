class CreateUserProgresses < ActiveRecord::Migration
  def change
    create_table :user_progresses do |t|
      t.integer :user_id
      t.integer :language_problem_id
      t.integer :status
      t.boolean :favorite

      t.timestamps null: false
    end

    add_index :user_progresses, :user_id
    add_index :user_progresses, :language_problem_id
  end
end
