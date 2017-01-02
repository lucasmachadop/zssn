Rails.application.routes.draw do
  resources :infection_reports, only: [:index]
  
  resources :resources

  resources :survivors do
  	member do  
  		put :last_location
  		patch :last_location
  		post :report_infection
  		post :trade
  	end
  end	

  get 'reports/infected', to: 'reports#show_infected_rate'
  get 'reports/non-infected', to: 'reports#show_non_infected_rate'
  get 'reports/resources_averages', to: 'reports#show_resources_averages'
  get 'reports/points_lost', to: 'reports#show_points_lost_by_infection'

end
