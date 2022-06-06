require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  feature 'Categories page' do
    given(:taxonomy1) { create(:taxonomy) }
    given(:taxonomy2) { create(:taxonomy) }
    given(:root1) { taxonomy1.root }
    given(:root2) { taxonomy2.root }
    given(:taxon1) { create(:taxon, taxonomy: taxonomy1, parent: root1, name: 'taxon1') }
    given(:taxon2) { create(:taxon, taxonomy: taxonomy2, parent: root2) }
    given(:product1) { create(:product, taxons: [taxon1]) }
    given(:product2) { create(:product, taxons: [taxon2], price: 20) }
    given(:image1) { create(:image) }
    given(:image2) { create(:image) }
    given!(:filename) { image1.attachment_blob.filename }
    given!(:file) { "#{filename.base}#{filename.extension_with_delimiter}" }

    background do
      product1.images << image1
      product2.images << image2
      visit potepan_category_path(taxon1.id)
    end

    scenario 'display categories page' do
      expect(page).to have_title "#{taxon1.name} - BIGBAG Store"
      expect(page.all(".productBox").count).to eq taxon1.products.count
      within ".side-nav" do
        expect(page).to have_content taxonomy1.name
        expect(page).to have_content taxon1.name
        expect(page).to have_content taxon2.name
      end
      within ".productBox" do
        expect(page).to have_content product1.name
        expect(page).to have_content product1.display_price.to_s
        expect(page).not_to have_content product2.name
        expect(page).not_to have_content product2.display_price.to_s
        expect(page).to have_selector "img[src$='#{file}']"
      end
    end

    scenario 'move products page from category page in productBox class' do
      click_on product1.name
      expect(current_path).to eq potepan_product_path(product1.id)
    end

    scenario 'move other categories page from category page in side-nav class' do
      click_on taxon2.name
      expect(current_path).to eq potepan_category_path(taxon2.id)
    end

    scenario 'move home from product page' do
      within '.breadcrumb' do
        click_link 'Home'
        expect(current_path).to eq potepan_index_path
      end
    end
  end
end
