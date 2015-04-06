class AddDefaultToUserProgress < ActiveRecord::Migration
  def change
    change_column :user_progresses, :status, :integer, :default => 0
    change_column :user_progresses, :favorite, :boolean, :default => false
  end
end
