require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    # let(:taxon) { create(:taxon, parent_id: taxonomy.root.id, taxonomy: taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_category_path(taxon.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "have taxon.name" do
      expect(response.body).to include(taxon.name)
    end

    it "have taxonomy.name" do
      expect(response.body).to include(taxonomy.name)
    end

    # it 'have product.name' do
    #   binding.pry
    #   products.each do |product|
    #     expect(response.body).to include(product.name)
    #   end
    #     expect(response.body).to include(product.name)
    # end

  end


end
