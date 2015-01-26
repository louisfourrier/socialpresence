class AddTokenToServices < ActiveRecord::Migration
  def change
    add_column :services, :access_token, :text
    add_column :services, :access_token_secret, :text
  end
end
