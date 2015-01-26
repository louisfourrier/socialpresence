class AddFieldsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :has_been_sent, :boolean, default: :false
    add_column :messages, :from_api, :boolean, default: :false
    add_column :messages, :sent_time, :datetime
  end
end
