class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.integer :phone
      t.string :address
      t.datetime :birthday
      t.integer :company_id
      t.string :position

      t.timestamps
    end
  end
end
