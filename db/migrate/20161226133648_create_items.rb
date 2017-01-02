class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :resource, foreign_key: true
      t.references :survivor, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
