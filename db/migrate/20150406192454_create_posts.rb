class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :language_problem_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
