class AddDeviseFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      # Indexes
      t.index :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    end

    # Alterar coluna existente
    if column_exists?(:users, :email)
      change_column :users, :email, :string, null: false, default: ""
    else
      add_column :users, :email, :string, null: false, default: ""
    end
  end
end
