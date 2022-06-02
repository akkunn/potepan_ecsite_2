require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let!(:filename) { image.attachment_blob.filename }
    let!(:file) { "#{filename.base}#{filename.extension_with_delimiter}" }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "has taxon.name" do
      expect(response.body).to include(taxon.name)
    end

    it "has taxonomy.name" do
      expect(response.body).to include(taxonomy.name)
    end

    it "has correct product.name" do
      expect(response.body).to include product.name
    end

    it "has correct product.price" do
      expect(response.body).to include product.display_price.to_s
    end

    it "has correct filename" do
      expect(response.body).to include file
    end
  end
end
