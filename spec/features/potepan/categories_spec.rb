require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  feature 'Categories page' do
    given(:taxonomy) { create(:taxonomy, name: 'Categories') }
    given(:taxon) { taxonomy.root }
    given(:clothing) { create(:taxon, name: 'Clothing', taxonomy: taxonomy, parent: taxon)}
    given(:shirts) { create(:taxon, name: 'Shirts', taxonomy: taxonomy, parent: clothing) }
    given!(:bags) { create(:taxon, name: 'Bags', taxonomy: taxonomy, parent: taxon) }
    given(:product1) { create(:product, name: 'Ruby Polo', price: 30, taxons: [shirts]) }
    given(:product2) { create(:product, name: 'Solidus Tote', price: 20, taxons: [bags]) }
    given(:image1) { create(:image) }
    given(:image2) { create(:image) }
    given!(:filename) {
      filename = image1.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    }

    background do
      product1.images << image1
      product2.images << image2
      visit potepan_category_path(shirts.id)
    end

    scenario 'display categories page' do
      expect(page).to have_title "#{shirts.name} - BIGBAG Store"
      within ".side-nav" do
        expect(page).to have_content taxonomy.name
        expect(page).to have_content shirts.name
        expect(page).to have_content shirts.products.count
        expect(page).to have_content bags.name
        expect(page).to_not have_content clothing.name
        # binding.pry
      end
      within ".productBox" do
        expect(page).to have_content product1.name
        expect(page).to have_content product1.display_price.to_s
        expect(page).to_not have_content product2.name
        expect(page).to_not have_content product2.display_price.to_s
        expect(page).to have_selector "img[src$='#{filename}']"
      end
    end
      # within ".lightSection.clearfix.pageHeader" do
      #   expect(page).to have_selector 'h2', text: taxon.name
      #   expect(page).to have_selector '.active', text: taxon.name
      # end

    scenario 'move products page from category page in productBox class' do
      click_on product1.name
      expect(current_path).to eq potepan_product_path(product1.id)
      expect(page).to have_title "#{product1.name} - BIGBAG Store"
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price.to_s
      expect(page).to_not have_content product2.name
      expect(page).to_not have_content product2.display_price.to_s
    end

    scenario 'move products page from category page in side-nav class' do
      click_on bags.name
      expect(current_path).to eq potepan_category_path(bags.id)
      expect(page).to have_title "#{bags.name} - BIGBAG Store"
      expect(page).to have_content product2.name
      expect(page).to have_content product2.display_price.to_s
      expect(page).to_not have_content product1.name
      expect(page).to_not have_content product1.display_price.to_s
    end

    scenario 'move home from product page' do
      within '.breadcrumb.pull-right' do
        click_link 'Home'
        expect(current_path).to eq potepan_index_path
      end
    end
  end
end

    # scenario "show products" do
    #   expect(page).to have_content product1.name
    #   expect(page).to have_content product1.display_price.to_s
    #   expect(page).to have_selector "img[src$='#{filename}']"

      # scenario 'moving success to index page' do
      #     find('.home').click
      #     expect(current_path).to eq potepan_index_path
      # end


      # binding.pry
      # expect(page).to have_selector "img[src$='#{rails_blob_path(product.display_image.attachment){:small}}']"
      # expect(page).to have_selector "img[src$='#{image.attachment(:small)}']"
      # expect(page).to have_selector "img[src$='#{product.display_image.attachment(:small)}']"
      # binding.pry


    # scenario 'display categories page' do
    #   within ".side-nav" do
    #     expect(page).to have_content taxonomy.name
    #   end
    #   within ".lightSection.clearfix.pageHeader" do
    #     expect(page).to have_selector 'h2', text: taxon.name
    #     expect(page).to have_selector '.active', text: taxon.name
    #   end
    # end
