class CreateLanguageProblems < ActiveRecord::Migration
  def change
    create_table :language_problems do |t|
      t.integer :language_id
      t.integer :problem_id

      t.timestamps null: false
    end

    add_index :language_problems, :language_id
    add_index :language_problems, :problem_id
  end
end
