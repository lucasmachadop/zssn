class CreateSurvivors < ActiveRecord::Migration[5.0]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.decimal :last_location_longitude
      t.decimal :last_location_latitude
      t.boolean :infected, :default => false 

      t.timestamps
    end
  end
end
