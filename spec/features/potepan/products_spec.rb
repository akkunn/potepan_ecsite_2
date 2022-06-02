require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  feature 'products page' do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }

    background do
      product.images << image
      visit potepan_product_path(product.id)
    end
    scenario 'display product page' do
      expect(page).to have_title "#{product.name} - BIGBAG Store"
      expect(page).to have_selector '.page-title h2', text: product.name
      expect(page).to have_selector '.active', text: product.name
      expect(page).to have_selector '.media-body h2', text: product.name
      expect(page).to have_content product.display_price.to_s
      expect(page).to have_content product.description
    end

    scenario 'move category page from product page' do
      click_link '一覧ページへ戻る'
      expect(page).to have_http_status(:success)
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

    scenario 'move home from product page' do
      within '.breadcrumb.pull-right' do
        click_link 'Home'
        expect(current_path).to eq potepan_index_path
      end
    end
  end
end
