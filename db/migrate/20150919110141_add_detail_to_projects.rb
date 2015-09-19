class AddDetailToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :name, :string
  	add_column :projects, :moxtra_binder, :string
  end
end
