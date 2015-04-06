class CreateUserProgresses < ActiveRecord::Migration
  def change
    create_table :user_progresses do |t|
      t.integer :user_id
      t.integer :language_problem_id
      t.integer :status
      t.boolean :favorite

      t.timestamps null: false
    end
  end
end
