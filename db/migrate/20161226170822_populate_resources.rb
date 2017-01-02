class PopulateResources < ActiveRecord::Migration[5.0]
  def self.up
  	resources = {:water=>4,:food=>3,:medication=>2,:ammunation=>1}
    
	resources.each do |k,v|
        Resource.create(:name=>k,:code=>v,:points=>v)
    end
  end

  def self.down
  	Resource.delete_all
  end
end
