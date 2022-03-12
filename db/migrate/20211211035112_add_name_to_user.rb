class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image, :string
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :terms, :boolean
    add_column :users, :location, :string
    add_column :users, :admin, :boolean, default: false
  end
end
