require 'rails_helper'

RSpec.describe "Repositories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search", vcr: { cassette_name: 'requests/repositories' } do
    it "appends the result to the frame" do
      get "/repositories/search", params: { search_term: 'octokit'}, as: :turbo_stream
      expect(response.media_type).to eq(Mime[:turbo_stream])
      expect(response.body).to include('<turbo-stream action="append" target="repositories">')
    end
  end
end
