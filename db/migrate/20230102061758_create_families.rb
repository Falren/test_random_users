class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :families, %i[parent_id child_id], unique: true
    add_index :families, :child_id
  end
end
