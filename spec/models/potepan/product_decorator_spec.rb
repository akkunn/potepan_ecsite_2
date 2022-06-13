require 'rails_helper'

RSpec.describe Spree::ProductDecorator, type: :model do
  describe "#related_products" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:related_products) { create_list(:product, 4, taxons: [taxon]) }

    it "returns related products" do
      expect(product.related_products).to match_array(related_products)
    end

    it "returns related products not in product" do
      expect(product.related_products).not_to include product
    end

    it "is uniq in related products" do
      expect(product.related_products == related_products.uniq).to eq true
    end
  end
end
