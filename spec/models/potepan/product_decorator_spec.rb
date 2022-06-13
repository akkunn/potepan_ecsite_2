require 'rails_helper'

RSpec.describe Spree::ProductDecorator, type: :model do
  describe "#related_products" do
    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon, taxon2]) }
    let(:related_products) { create_list(:product, 4, taxons: [taxon, taxon2]) }

    it "returns related products" do
      expect(product.related_products).to match_array(related_products)
    end

    it "returns related products not in product" do
      expect(product.related_products).not_to include product
    end

    it "is uniq in related products" do
      expect(product.related_products).to eq related_products.uniq
    end
  end
end
