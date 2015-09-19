class AddUserInformation < ActiveRecord::Migration
  def up
  	add_column :users, :email, :string, null: true
  	add_column :users, :bio, :text, null: true
  	add_column :users, :skills, :text, null: true
  	add_column :users, :image_url, :text, null: false
  end

  def down
  	remove_column :users, :email
  	remove_column :users, :bio
  	remove_column :users, :skills
  	remove_column :users, :image_url
  end
end
