class Resource < ApplicationRecord

	def self.averages
  		number_of_non_infected_survivors = Survivor.select(:id).where(:infected => false).count.to_f
	  	total_qnt_of_water = Item.joins(:resource).joins(:survivor).where("resources.name"=>:water, "survivors.infected"=>false).sum(:quantity).to_f
  		total_qnt_of_food = Item.joins(:resource).joins(:survivor).where("resources.name"=>:food, "survivors.infected"=>false).sum(:quantity).to_f
  		total_qnt_of_ammunation = Item.joins(:resource).joins(:survivor).where("resources.name"=>:ammunation, "survivors.infected"=>false).sum(:quantity).to_f
  		total_qnt_of_medication = Item.joins(:resource).joins(:survivor).where("resources.name"=>:medication, "survivors.infected"=>false).sum(:quantity).to_f

    	{:water_by_survivor => total_qnt_of_water/number_of_non_infected_survivors,
			:food_by_survivor => total_qnt_of_food/number_of_non_infected_survivors,
			:medication_by_survivor => total_qnt_of_medication/number_of_non_infected_survivors,
			:ammunation_by_survivor => total_qnt_of_ammunation/number_of_non_infected_survivors
		}
	end	

	def self.points_lost_by_infection
		Item.joins(:resource).joins(:survivor).where("survivors.infected"=>true).sum("points * quantity").to_f
	end	
end
