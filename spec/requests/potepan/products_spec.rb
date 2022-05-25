require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    before do
      get potepan_product_path(product.id)
    end

    let(:product) { create(:product) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "have product.name" do
      expect(response.body).to include(product.name)
    end

    it "have product.price" do
      expect(response.body).to include(product.price.to_s)
    end

    it "have product.description" do
      expect(response.body).to include(product.description)
    end
  end
end
