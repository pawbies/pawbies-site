class AddEmailVerifiedToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_verified, :boolean, null: false, default: false
  end
end
