require 'rails_helper'

RSpec.describe "Ipmatikas", type: :request do
  describe "GET /ipmatikas" do
    it "works! (now write some real specs)" do
      get ipmatikas_path
      expect(response).to have_http_status(200)
    end
  end
end
