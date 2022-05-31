class Potepan::CategoriesController < ApplicationController
  def show
    # binding.pry
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products
    # @products = Spree::Product.in_taxon(@taxon).includes(master: [:images, :default_price])
    # @products = Spree::Product.in_taxon(@taxon)
    # binding.pry
    @taxonomies = Spree::Taxonomy.all
    # @taxonomies = Spree::Taxonomy.includes(:root)
  end
end
