class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true
      t.string :phone_number, null: false
      t.datetime :sign_up_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :user_role, default: 0, null: false

      t.timestamps
    end
  end
end
