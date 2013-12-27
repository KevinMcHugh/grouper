class CreateGroupsPeopleJoinTable < ActiveRecord::Migration
  def change
    create_table :groups_people, id: false do |t|
      t.integer :group_id
      t.integer :person_id
    end
  end
end