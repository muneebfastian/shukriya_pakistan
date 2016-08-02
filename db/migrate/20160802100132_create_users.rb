class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.decimal :latitude
      t.decimal :longitude
      t.text :message
      t.string :profile_url
      t.string :fb_id

      t.timestamps null: false
    end
  end
end
