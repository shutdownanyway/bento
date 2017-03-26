class StoreController < ApplicationController
  def index
    @categories = Category.all

      @products = Product.order(updated_at: :desc).all.page params[:page]

  end

  def new_products
    @new =  Product.order(updated_at: :desc).where("created_at > ?", 1.day.ago).page(params[:page])
    @categories = Category.all
  end

  def updated_products
    @updated_products =  Product.order(updated_at: :desc).where("updated_at> ?", 1.day.ago).page(params[:page])
    @categories = Category.all
  end

  def sale
    @products_on_sale = Product.order(updated_at: :desc).where("discount > 0").page(params[:page])
    @categories = Category.all
  end
end
