# README

Things you may want to cover:

* Ruby version 2.3.3

* Rails version 5.0.1

* Database Postgresql 9.3

* How to run the test suite: bundle exec rspec spec

* Endpoint List 
I.  Http Method
II. Url Patch
III.Data
IV. Description							

1.     	I. GET           II.  /survivors		III. list all survivors registered

2.     	I. GET           II.  /survivors/:id  	III. shows information about survivor with id=:id

3.		I. POST			 II.  /survivors		III. creates a new survivor and its items				IV.	{												
																										  "survivor":{
																										      "name":[string],
																										      "age":[integer],
																										      "gender":[string],
																										      "last_location_longitude":[float],
																										      "last_location_latitude":[float],
																										      "items":{
																										          "water": [integer]
																										          //valid "items" keys: "water",
																										          //"food", "medication" and "ammnutaion".
																										      }
																										  }
																										}

4.		a. POST 		 b.	/survivors/:id/report_infection	c.	{												d. reports a survivor as infected																					"infected_id":[integer]
																}

5.		POST 			/survivors/:id/trade				{
																"trade":{
																	"survivor_id":[integer],
																	"items_to_give":{
																		"food":[integer]
																		//valid "items_to_give" keys: "water",
																		//"food", "medication" and "ammnutaion".
																	},
																	"items_to_receive":{
																		"medication":[integer]
																		//valid "items_to_receive" keys: "water",
																		//"food", "medication" and "ammnutaion".
																	}
																}
															}															

															 

6.		PUT/PATCH		/survivors/:id 						{													updates survivor with id=:id
															  "survivor":{
															      "name":[string],
															      "age":[integer],
															      "gender":[string],
															      "last_location_longitude":[float],
															      "last_location_latitude":[float]
															  }
															}	

7.		PUT/PATCH		/survivors/:id/last_location 		{													updates survivor with id=:id last location
																"latitude": [float],
																"longitude": [float]
															}	

8.      DELETE			/survivors/:id 																			destroy survivor


=======
# zssn
Zombie Survival Social Network

