class AddFieldsToServices < ActiveRecord::Migration
  def change
    add_column :services, :service_token, :text
    add_column :services, :tags, :text
    
    add_index :services, :service_token
  end
end
