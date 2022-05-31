require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  feature 'Categories page' do
    given(:taxon) { create(:taxon) }
    given(:taxonomy) { create(:taxonomy) }
    given(:product) { create(:product, taxons: [taxon]) }

    background do
      visit potepan_category_path(taxon.id)
    end

    scenario 'display categories page' do
      # binding.pry
      expect(page).to have_selector 'h2', text: taxon.name
      # binding.pry
      # expect(page).to have_selector 'h5', text: product.name
      expect(page).to have_selector '.active', text: taxon.name
    end

    # scenario 'moving success to products page' do
    #   click_on product.name
    #   expect(current_path).to eq potepan_product_path(product.id)
    # end
  end
end
