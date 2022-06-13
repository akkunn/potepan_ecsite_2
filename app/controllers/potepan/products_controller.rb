class Potepan::ProductsController < ApplicationController
  COUNT_MAX_RELATED_PRODUCTS = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.includes(master: [:default_price, :images]).
      limit(COUNT_MAX_RELATED_PRODUCTS)
  end
end
