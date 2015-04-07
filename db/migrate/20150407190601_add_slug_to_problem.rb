class AddSlugToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :slug, :string
    add_index :problems, :slug, unique: true
  end
end
