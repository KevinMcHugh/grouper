class FixBelongsMappings < ActiveRecord::Migration
  def change
  rename_column :people, :groups_id, :group_id
    rename_column :groups, :events_id, :event_id
  end
end
