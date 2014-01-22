class RemoveGroupIdFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :group_id, :number
  end
end
