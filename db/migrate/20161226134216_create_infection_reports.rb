class CreateInfectionReports < ActiveRecord::Migration[5.0]
  def change
    create_table :infection_reports do |t|
      t.integer :reporter_survivor_id,:null =>false
      t.integer :reported_survivor_id,:null =>false

      t.timestamps
    end
  end
end
