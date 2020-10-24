class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false 
      t.string :email, null: false 
      t.string :password_digest 
      t.boolean :suspended, null: false, default: false 
      t.text :profile 
      t.string :profile_image_id 

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
