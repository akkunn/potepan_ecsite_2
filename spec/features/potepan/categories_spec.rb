require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  feature 'Categories page' do
    given(:taxon) { create(:taxon) }
    given(:taxonomy) { create(:taxonomy) }
    given(:products) { create(:product, taxons: [taxon]) }

    background do
      visit potepan_category_path(taxon.id)
    end

    scenario 'display categories page' do
      expect(page).to have_selector 'h2', text: taxon.name
      expect(page).to have_selector '.active', text: taxon.name
      # expect(page).to have_selector 'h5', text: products.name
    end

    scenario 'moving success to index page' do
        find('.home').click
        expect(current_path).to eq potepan_index_path
    end

  end
end
