class AddForeignKeyIndexes < ActiveRecord::Migration
  def change
    add_index :events_people, :event_id
    add_index :events_people, :person_id
    add_index :groups, :event_id
    add_index :groups_people, :group_id
    add_index :groups_people, :person_id
  end
end
