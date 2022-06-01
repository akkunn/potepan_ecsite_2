class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(:root)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.includes(master: [:default_price, :images])
    # binding.pry
  end
end





# binding.pry
# @taxonomies = Spree::Taxonomy.all
# @products = Spree::Product.in_taxon(@taxon).includes(master: [:images, :default_price])
# @products = Spree::Product.in_taxon(@taxon)
# binding.pry
