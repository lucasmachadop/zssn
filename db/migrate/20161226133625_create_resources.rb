class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.integer :points
      t.integer :code

      t.timestamps
    end
  end
end
