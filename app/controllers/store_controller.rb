class StoreController < ApplicationController
  def index
    @categories = Category.all

      @products = Product.all.page params[:page]

  end

  def new_products
    @new =  Product.where("created_at > ?", 1.day.ago)
    @products = Product.all.page params[:page]

  end

  def updated_products
    @updated_products =  Product.where("updated_at> ?", 1.day.ago)
    @products = Product.all.page params[:page]
  end

  def sale
    @products_on_sale = Product.where("discount > 0")
    @products = Product.all.page params[:page]
  end
end
