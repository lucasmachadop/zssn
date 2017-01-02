require 'rails_helper'

RSpec.describe "InfectionReports", type: :request do
  describe "GET /infection_reports" do
    it "works! (now write some real specs)" do
      get infection_reports_path
      expect(response).to have_http_status(200)
    end
  end
end
