class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(:root)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.includes(master: [:default_price, :images])
  end
end
