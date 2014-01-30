class AddUuidToPeople < ActiveRecord::Migration
  class Person < ActiveRecord::Base
  end

  def change
    add_column :people, :uuid, :string
    Person.reset_column_information
    reversible do |dir|
      dir.up do 
        Person.all.each do |person|
          person.update uuid: SecureRandom.uuid 
        end
      end
    end
  end
end
