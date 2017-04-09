class ProductsController < ApplicationController
  # def index
  #
  #   @category = Category.params[:id]
  #   @products = @category.product
  #
  #   @products = Product.order(updated_at: :desc).all.page params[:page]
  #   @categories = Category.all
  #
  # end

  def show
    @product = Product.find(params[:id])
    @categories = Category.all
    
  end


  # def cart_list
  #
  #
  #     Product.find(session[:cart_list])
  #     # product = Product.find(session[:cart_list])
  #     #
  #     #  product.each do |item|
  #     #    item.update_columns(quantity: 1)
  #     #  end
  #
  #   end

  # def add_to_cart
  #   id = params[:id].to_i
  #   session[:cart_list] << id unless session[:cart_list].include?(id)
  #   #session[:added_to_cart] += 1
  #   #@cart_items = session[:added_to_cart]
  #   redirect_back(fallback_location: root_path)
  #  end
  #
  # private
  #
  # def initialize_session
  #   session[:visit_count] ||= 0
  #   session[:cart_list] ||= []
  #   #session[:added_to_cart] ||= []
  # end
  #
  # def cart_list
  #   Product.find(session[:cart_list])
  # end
  # helper_method :cart_list

  # def categorized_products
  #   @customers_alphabetized =  Product.where("created_at > ?", 1.day.ago)
  # end

end
