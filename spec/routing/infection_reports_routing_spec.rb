require "rails_helper"

RSpec.describe InfectionReportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/infection_reports").to route_to("infection_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/infection_reports/new").to route_to("infection_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/infection_reports/1").to route_to("infection_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/infection_reports/1/edit").to route_to("infection_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/infection_reports").to route_to("infection_reports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/infection_reports/1").to route_to("infection_reports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/infection_reports/1").to route_to("infection_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/infection_reports/1").to route_to("infection_reports#destroy", :id => "1")
    end

  end
end
