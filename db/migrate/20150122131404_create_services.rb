class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.text :total_field
      t.references :user, index: true

      t.timestamps
    end
  end
end
