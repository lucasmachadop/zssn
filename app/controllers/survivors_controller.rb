class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy, :last_location, :report_infection, :trade]

  # GET /survivors
  def index
    @survivors = Survivor.all
    render json: @survivors, include: 'items.resource.name'
  end

  # GET /survivors/1
  def show
    render json: @survivor, include: 'items.resource.name'
  end

  # POST /survivors/1/trade
  def trade
    @trade_survivor = Survivor.find(survivor_trade_params[:survivor_id])
    traders = Survivor.exchange_between_survivors(@survivor, @trade_survivor, survivor_trade_params[:items_to_give],survivor_trade_params[:items_to_receive])
    # render json: {:survivor_itens => traders[0], :trade_}
    render json: {
          #TODO: refazer com active model serializer
          :survivor => @survivor.as_json( :include => 
                      {:items => {:only => :quantity, :include => 
                        {:resource =>{:only => :name}}
                        }
                    },:except => [:created_at, :updated_at, :infected,:gender,:age]
          ), 

          :trade_survivor => @trade_survivor.as_json( :include => 
                      {:items => {:only => :quantity, :include => 
                        {:resource =>{:only => :name}}
                        }
                    },:except => [:created_at, :updated_at, :infected, :gender,:age]
          )
      }
  end

  # POST /survivors/1/report_infection
  def report_infection
    @reported = Survivor.find_by(:id=>infected_param[:infected])
    # infection_report = InfectionReport.new(:reporter_survivor => @survivor, :reported_survivor => @reported)
    # infection_report.save_and_verify_occurrences
    infection_report = @survivor.report_infection(@reported)
    render json: infection_report
  end

  # PATCH/PUT /survivors/1/last_location
  def last_location
    @survivor.update(:last_location_longitude => last_location_params[:longitude],
      :last_location_latitude => last_location_params[:latitude])

    render json: @survivor
  end  

  # POST /survivors
  def create

    @survivor = Survivor.new(survivor_params)
    
    if @survivor.save

      survivor_items_params.each do |type,qtd|
        item = Item.factory(type,@survivor,qtd)
        item.save  
      end
      render json: @survivor,include: 'items.resource.name', status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/1
  def update
    if @survivor.update(survivor_params)
      render json: @survivor, include: 'items.resource.name'
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /survivors/1
  def destroy
    @survivor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :last_location_longitude, :last_location_latitude)
    end

    def survivor_items_params
      params.require(:survivor).permit(items:[:water,:food,:ammunation,:medication])[:items]
    end


    def survivor_trade_params
      params.require(:trade).permit(:survivor_id,items_to_give:[:water,:food,:ammunation,:medication],items_to_receive:[:water,:food,:ammunation,:medication])
    end

    def last_location_params
      # params.require(:survivor).permit(:longitude,:latitude)
      params.permit(:longitude,:latitude)
    end

    def infected_param
      params.permit(:infected)
    end

    
  end
