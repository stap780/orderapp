# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "Orderstatuses", type: :request do
  describe "GET /orderstatuses" do
    it "works! (now write some real specs)" do
      get orderstatuses_path
      expect(response).to have_http_status(200)
    end
  end
end
