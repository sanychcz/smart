class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :web
      t.string :email
      t.string :address
      t.integer :phone
      t.integer :ico
      t.integer :dic

      t.timestamps
    end
  end
end
