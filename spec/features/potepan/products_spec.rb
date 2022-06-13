require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  feature 'products page' do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let(:related_products) { create_list(:product, 4, taxons: [taxon]) }
    let(:related_products_images) { create_list(:image, 4) }
    let(:other_related_products) { create_list(:product, 5, taxons: [taxon]) }
    let(:other_related_products_images) { create_list(:image, 5) }

    background do
      product.images << image
      related_products.each_with_index do |related_product, i|
        related_product.images << related_products_images[i]
      end
      other_related_products.each_with_index do |other_related_product, i|
        other_related_product.images << other_related_products_images[i]
      end
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
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

    scenario 'move home from product page' do
      within '.breadcrumb' do
        click_link 'Home'
        expect(current_path).to eq potepan_index_path
      end
    end

    scenario 'display related products' do
      related_products.each do |related_product|
        expect(page).to have_content related_product.name
        expect(page).to have_content related_product.display_price.to_s
      end
    end

    scenario 'move product page in related products' do
      related_products.each do |related_product|
        click_link related_product.name
        expect(current_path).to eq potepan_product_path(related_product.id)
      end
    end

    scenario 'correct count of related products' do
      expect(page).to have_selector '.productBox', count: 4
    end

    scenario 'display other related products' do
      other_related_products.each do |other_related_product|
        expect(page).to have_selector '.productBox', count: 4
      end
    end
  end
end
