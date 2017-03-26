class ProductsController < ApplicationController
  def index

    @category = Category.params[:id]
    @products = @category.product

    @products = Product.all.page params[:page]
    @categories = Category.all

  end

  def show
    @product = Product.find(params[:id])
  end

  def categorized_products
    @customers_alphabetized =  Product.where("created_at > ?", 1.day.ago)
  end

end
