class StoreController < ApplicationController
  before_action :initialize_session
  # before_action :increment_visit_count
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

  def add_to_cart
    id = params[:id].to_i
    session[:cart_list] << id unless session[:cart_list].include?(id)
    #session[:added_to_cart] +=1
    #@cart_items = session[:added_to_cart]
    redirect_back(fallback_location: root_path)
    # session[:visit_count] += 1
    # @visit_count = session[:visit_count]
    product = Product.find(session[:cart_list])
   
    product.each do |item|
      item.update_columns(quantity: 1)
    end
   end

   def remove_from_cart
     id = params[:id].to_i
     session[:cart_list].delete(id)
     redirect_back(fallback_location: root_path)
   end

   def cart_list
    @categories = Category.all

    Product.find(session[:cart_list])
    # product = Product.find(session[:cart_list])
    #
    #  product.each do |item|
    #    item.update_columns(quantity: 1)
    #  end

   end

   def update_quantity
    #  product = Product.find(session[:cart_list])
     #
    #   product.each do |item|
    #     item.update_columns(quantity: quantity)
    #   end
   @line_item = Product.find(params[:id])
   @line_item.quantity = params[:item][:quantity]
   @line_item.update_columns(quantity: @line_item.quantity)
   end

  private

  def initialize_session
    # session[:visit_count] ||= 0
    session[:cart_list] ||= []
    #session[:added_to_cart] ||= 0
  end

  #  def increment_visit_count
  #    session[:visit_count] += 1
  #    @visit_count = session[:visit_count]
  #  end


   def number_of_cart_items
     @cart_list_count = Product.find(session[:cart_list]).count
   end
   helper_method :cart_list
   helper_method :number_of_cart_items
end
