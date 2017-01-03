require 'rails_helper'

RSpec.describe Survivor, type: :model do
	before do
    	@survivor = FactoryGirl.create(:survivor)
    	@survivor2 = FactoryGirl.create(:survivor)

    	@infected = FactoryGirl.create(:survivor,infected:true)
  	end

  	it "has a valid factory" do
		@survivor.should be_valid 
	end

  	it "has a name, a gender and a sex" do 
		survivor = FactoryGirl.build(:survivor,name:nil,gender:nil,age:nil)  		
		survivor.should_not be_valid
		survivor.name = "Lucas"
		survivor.should_not be_valid
		survivor.age = 25
		survivor.should_not be_valid
		survivor.gender ="M"
		survivor.should be_valid
  	end 

  	it "has last location coordinates" do
  		survivor = FactoryGirl.build(:survivor,last_location_longitude:nil,last_location_latitude:nil)  
  		survivor.should_not be_valid
  		survivor.last_location_longitude=1.1
		survivor.should_not be_valid
		survivor.last_location_latitude=-2.001
  		survivor.should be_valid
  	end  

  	it "is marked as non infected by default" do
  		@survivor.infected.should_not be nil
  		@survivor.infected.should_not be true
  	end	

  	it "has 'M' or 'F' as gender" do 
  		survivor = FactoryGirl.build(:survivor,gender:'teste')
  		survivor.should_not be_valid
  		survivor = FactoryGirl.build(:survivor,gender:'A')
  		survivor.should_not be_valid
  		survivor.gender = 'M'  
  		survivor.should be_valid
  		survivor.gender = 'F'  
  		survivor.should be_valid
  	end	

  	it "may have items" do
  		@survivor.items.should be_empty
  		item = FactoryGirl.create(:item,survivor:@survivor,resource:FactoryGirl.create(:resource),quantity:5)
  		@survivor.items.should_not be_empty
  		@survivor.items.first.resource.name.should eq "test"

  	end	

  	it "exchanges items with other survivors" do 
  		item_survivor = FactoryGirl.create(:item,survivor:@survivor,resource:FactoryGirl.create(:resource),quantity:1)
  		item_survivor2 = FactoryGirl.create(:item,survivor:@survivor2,resource:FactoryGirl.create(:resource,name:"gold"),quantity:1)
  		items_to_give = {"test":1}
  		items_to_receive = {"gold":1}
  		Survivor.exchange_between_survivors(@survivor,@survivor2,items_to_give,items_to_receive)
  		@survivor.items.first.resource.name.should eq "gold"
  		@survivor2.items.first.resource.name.should eq "test"
  	end	

  	it "cannot trade if infected" do 
		item_survivor = FactoryGirl.create(:item,survivor:@survivor,resource:FactoryGirl.create(:resource),quantity:1)
  		item_survivor2 = FactoryGirl.create(:item,survivor:@infected,resource:FactoryGirl.create(:resource,name:"gold"),quantity:1)
  		items_to_give = {"test":1}
  		items_to_receive = {"gold":1}
  		expect{
  			Survivor.exchange_between_survivors(@survivor,@infected,items_to_give,items_to_receive)
  		}.to raise_error("Infected survivor MyString cannot trade!")
  		@survivor.items.first.resource.name.should_not eq "gold"
  		@infected.items.first.resource.name.should_not eq "test"
  	end	

  	it "cannot trade items it does not have or has in smaller quantities" do
  		FactoryGirl.create(:resource,name:"item_unknown")
  		item_survivor = FactoryGirl.create(:item,survivor:@survivor,resource:FactoryGirl.create(:resource),quantity:1)
  		item_survivor2 = FactoryGirl.create(:item,survivor:@survivor2,resource:FactoryGirl.create(:resource,name:"gold"),quantity:1)
  		items_to_give = {"item_unknown":1}
  		items_to_receive = {"gold":1}
  		expect{
  			Survivor.exchange_between_survivors(@survivor,@survivor2,items_to_give,items_to_receive)
  		}.to raise_error("Survivor MyString doesn't have item_unknown to trade.")
  		items_to_give = {"test":2}
  		expect{
  			Survivor.exchange_between_survivors(@survivor,@survivor2,items_to_give,items_to_receive)
  		}.to raise_error("Survivor MyString have only 1 test to trade.")
  		@survivor.items.first.resource.name.should_not eq "gold"
  		@survivor2.items.first.resource.name.should_not eq "test"
  	end	

  	it "can report infections" do 
		report = @survivor.report_infection(@survivor2)
		report.should be_valid
		report.reported_survivor.should eq @survivor2
  		report.reported_survivor.should_not eq @survivor
		report.reporter_survivor.should eq @survivor
  	end	

end