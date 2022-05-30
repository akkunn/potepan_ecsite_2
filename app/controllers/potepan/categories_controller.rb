class Potepan::CategoriesController < ApplicationController
  def show
    # binding.pry
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products
    @taxonomies = Spree::Taxonomy.all
  end
end
