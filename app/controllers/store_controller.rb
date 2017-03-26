class StoreController < ApplicationController
  def index
    @categories = Category.all

      @products = Product.all.page params[:page]
    
  end

  def categorized
  end
end
