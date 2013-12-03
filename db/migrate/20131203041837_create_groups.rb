class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :events
      t.timestamps
    end
    change_table :people do |t|
      t.belongs_to :groups
  	end
  end
end
