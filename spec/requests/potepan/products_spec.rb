require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    let(:product) { create(:product) }
    it "returns http success" do
      # binding.pry
      get :show, params: {id: product.id}
      # get '/products/1' 
      # get "/products/#{product.id}", params: {id: product.id}
      # get "/products/#{product.id}"

      expect(response).to have_http_status(:success)
    end
  end

end
