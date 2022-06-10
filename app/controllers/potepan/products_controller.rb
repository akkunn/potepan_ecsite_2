class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.in_taxons(@product.taxons).includes(master: [:default_price, :images]).where.not(id: @product.id).distinct.limit(4)
  end
end
