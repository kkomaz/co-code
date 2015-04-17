class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :lesson_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :invitations, :lesson_id
    add_index :invitations, :user_id
  end
end
