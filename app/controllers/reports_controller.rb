class ReportsController < ApplicationController
 

 def show_infected_rate
    render json: {:infected_rate => InfectionReport.rate(true)} 
 end


 def show_non_infected_rate
    render json: {:non_infected_rate => InfectionReport.rate(false)} 
 end
  
 def show_resources_averages
    render json: {:resources_averages_by_non_infected_survivor => Resource.averages} 
 end 

 def show_points_lost_by_infection
    render json: {:points_lost_by_infection => Resource.points_lost_by_infection}
  end
  
end
