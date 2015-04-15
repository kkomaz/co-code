class RemoveHostIdFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :host_id
  end
end
