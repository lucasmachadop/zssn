class CreateSurvivors < ActiveRecord::Migration[5.0]
  def change
    create_table :survivors do |t|
      t.string :name,:null =>false
      t.integer :age,:null =>false
      t.string :gender,:null =>false
      t.decimal :last_location_longitude,:null =>false
      t.decimal :last_location_latitude, :null =>false
      t.boolean :infected, :default => false,:null =>false

      t.timestamps
    end
  end
end
