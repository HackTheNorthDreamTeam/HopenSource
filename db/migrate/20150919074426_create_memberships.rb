class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :memberships do |t|
    	t.integer :user_id
    	t.integer :project_id

      t.timestamps null: false
    end

    add_index :memberships, :user_id
    add_index :memberships, :project_id
    add_index :memberships, [:project_id, :user_id]
  end

  def down
  	delete_table :memberships
  end
end
