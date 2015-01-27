class AddPersonToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :person, :string
  end
end
