require 'rails_helper'

RSpec.describe "ImportFiles", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/import_files/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/import_files/show"
      expect(response).to have_http_status(:success)
    end
  end

end
