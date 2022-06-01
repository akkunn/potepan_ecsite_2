require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  feature 'Categories page' do
    given(:taxon) { create(:taxon) }
    given(:taxonomy) { create(:taxonomy) }
    given(:product) { create(:product, taxons: [taxon]) }
    given(:image) { create(:image) }

    background do
      visit potepan_category_path(taxon.id)
    end

    scenario 'display categories page' do
      within ".side-nav" do
        expect(page).to have_content taxonomy.name
      end
      within ".lightSection.clearfix.pageHeader" do
        expect(page).to have_selector 'h2', text: taxon.name
        expect(page).to have_selector '.active', text: taxon.name
      end
    end

    # scenario 'product information' do
    #   # binding.pry
    #     expect(page).to have_content taxon.products.first.name

    # end

    scenario 'moving success to index page' do
        find('.home').click
        expect(current_path).to eq potepan_index_path
    end

  end
end
