class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :service, index: true
      t.text :service_token
      t.text :content
      t.text :url
      t.text :from_url
      t.text :tags

      t.timestamps
    end
  end
end
