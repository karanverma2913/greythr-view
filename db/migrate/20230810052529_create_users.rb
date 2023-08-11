class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :role
      t.date :joining_date
      t.integer :salary
      t.float :balance
      t.string :type

      t.timestamps
    end
  end
end
