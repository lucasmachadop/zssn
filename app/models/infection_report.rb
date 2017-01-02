class InfectionReport < ApplicationRecord
  belongs_to :reporter_survivor, class_name: "Survivor"
  belongs_to :reported_survivor, class_name: "Survivor"

  # validates_presence_of :reporter_survivor_id, :reported_survivor_id

  def save_and_verify_occurrences
  	self.save
  	ocurrences_with_reported =InfectionReport.select(:id).where(:reported_survivor_id => self.reported_survivor.id).count 
  	self.reported_survivor.mark_as_infected if ocurrences_with_reported > 2
  end

  def self.rate infected_ones 
  	 number_of_survivors = Survivor.count
  	 number_of_ocurrences = Survivor.select(:id).where(:infected => infected_ones).count
  	 "#{100*number_of_ocurrences.to_f/number_of_survivors.to_f}%"
  end	
end
