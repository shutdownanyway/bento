class CategoryController < ApplicationController
  def index
    @categories = Category.order(updated_at: :desc).all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(updated_at: :desc)
    @categories = Category.all
    # @products = Product.all.page params[:page]
  end

  def index
    @products = @category.products
    # @products = Product.all.page params[:page]
  end


end
