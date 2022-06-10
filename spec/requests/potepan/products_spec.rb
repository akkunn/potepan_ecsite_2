require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    before do
      related_products.each_with_index do |related_product, i|
        related_product.images << related_products_images[i]
      end
      get potepan_product_path(product.id)
    end

    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:related_products) { create_list(:product, 4, taxons: [taxon]) }
    let(:related_products_images) { create_list(:image, 4) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "have product.name" do
      expect(response.body).to include(product.name)
    end

    it "have product.price" do
      expect(response.body).to include(product.display_price.to_s)
    end

    it "have product.description" do
      expect(response.body).to include(product.description)
    end

    it "have related product" do
      related_products.each do |related_product|
        expect(response.body).to include(related_product.name)
        expect(response.body).to include(related_product.display_price.to_s)
      end
    end
  end
end
