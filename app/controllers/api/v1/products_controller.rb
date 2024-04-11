class Api::V1::ProductsController < ApplicationController

  def index
    render json: { products: Product.all }
  end

end
