class Survivor < ApplicationRecord
	has_many :items, dependent: :destroy
	has_many :infection_reports_received, class_name: "InfectionReport", foreign_key: "reported_survivor_id"
	has_many :infection_reports_given, class_name: "InfectionReport", foreign_key: "reporter_survivor_id"

	validates_presence_of :last_location_latitude, :last_location_longitude, :age, :gender, :name

  	GENDER_OPTIONS = %w(M F)
	validates :gender, :inclusion => {:in =>  GENDER_OPTIONS}

	def self.exchange_between_survivors(survivor,trade_survivor,items_to_give, items_to_receive)
		for s in [survivor,trade_survivor] do 
			raise "Infected survivor #{s.name} cannot trade!" if s.infected?
		end	
		Survivor.transaction do 
			survivor.trade(items_to_give,items_to_receive)
			trade_survivor.trade(items_to_receive,items_to_give)
		end
	end

	def trade (items_to_give, items_to_receive)
		points_given = give items_to_give 	
		points_received = receive items_to_receive
		
		raise "Trade's items total points do not match. Survivor #{self.name} giving #{points_given}"\
		 " and receiving #{points_received} points." unless points_given == points_received
	end		

	def give items
		trade_points = 0
		items.each do |resource_name, qtd|
			resource = Resource.find_by(:name=>resource_name)	
			item = Item.find_by(:resource_id => resource.id, :survivor_id  => self.id)
			raise "Survivor #{self.name} doesn't have #{resource_name} to trade." unless item
			raise "Survivor #{self.name} have only #{item.quantity} #{resource_name} to trade." unless item.quantity >= qtd
			item.quantity -= qtd
			if item.quantity > 0
				item.save 
			else
				item.destroy
			end
			trade_points += resource.points * qtd
		end
		trade_points
	end

	def receive items
		trade_points = 0
		items.each do |resource_name, qtd|
			resource = Resource.find_by(:name=>resource_name)
			item = Item.find_by(:resource_id => resource.id, :survivor_id  => self.id)
			unless item 
				item = Item.new(:resource=>resource, :survivor=>self, :quantity=> qtd)
			else
				item.quantity += qtd
			end	
			trade_points += resource.points * qtd
			item.save 
		end
		trade_points
	end

	def report_infection reported 
		infection_report = InfectionReport.new(:reporter_survivor => self, :reported_survivor => reported)
    	infection_report.save_and_verify_occurrences
		infection_report
	end
		
	def mark_as_infected
		self.infected = true
		self.save
	end	

 
end
