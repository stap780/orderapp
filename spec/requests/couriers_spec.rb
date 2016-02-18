require 'rails_helper'

RSpec.describe "Couriers", type: :request do
  describe "GET /couriers" do
    it "works! (now write some real specs)" do
      get couriers_path
      expect(response).to have_http_status(200)
    end
  end
end
