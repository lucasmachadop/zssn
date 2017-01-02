class InfectionReportsController < ApplicationController
  before_action :set_infection_report, only: [:show, :update, :destroy]

  # GET /infection_reports
  def index
    @infection_reports = InfectionReport.all

    render json: @infection_reports
  end

  # GET /infection_reports/1
  def show
    render json: @infection_report
  end

  # POST /infection_reports
  def create
    @infection_report = InfectionReport.new(infection_report_params)

    if @infection_report.save
      render json: @infection_report, status: :created, location: @infection_report
    else
      render json: @infection_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /infection_reports/1
  def update
    if @infection_report.update(infection_report_params)
      render json: @infection_report
    else
      render json: @infection_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /infection_reports/1
  def destroy
    @infection_report.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infection_report
      @infection_report = InfectionReport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def infection_report_params
      params.require(:infection_report).permit(:reporter_survivor_id, :reported_survivor_id)
    end
end
