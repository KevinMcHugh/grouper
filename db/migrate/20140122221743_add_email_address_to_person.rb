class AddEmailAddressToPerson < ActiveRecord::Migration
  def change
    add_column :people, :email_address, :string
  end
end
