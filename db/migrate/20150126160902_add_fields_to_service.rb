class AddFieldsToService < ActiveRecord::Migration
  def change
    add_column :services, :email_alert, :boolean, default: false
    add_column :services, :automatic_follow, :boolean, default: true
  end
end
