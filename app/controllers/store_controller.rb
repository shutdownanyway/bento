class StoreController < ApplicationController
  before_action :initialize_session
  def index
    @categories = Category.all

      @products = Product.order(updated_at: :desc).all.page params[:page]
  @line_item = current_order.line_items.new

  end

  def search
  end

  def search_results

    @categories = Category.all
    keywords = '%'+ params[:search_keywords] + '%'
    @found_products_any_category =  Product.where("name ILIKE ? OR description ILIKE ?",
    keywords,keywords)
    @found_products_with_category = Product.order(name: :asc).where("(name ILIKE ? OR description ILIKE ?) AND category_id = ?",
    keywords, keywords, params[:search_category])

  end

  def show
    @product = Product.find(params[:id])
    @categories = Category.all

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
    product = Product.find(id)
    price = product.price
    session[:cart_list] << id unless session[:cart_list].include?(id)
      @order = current_order
    @line_item = @order.line_items.new(quantity: 1, product_id: id, price: price, total: price, session: request.session.id )
     @order.order_status_id = 1
     if user_signed_in?
       @order.user_id = current_user.id
     end
     @order.shipping = 5
      @order.save
      session[:order_id] = @order.id
    redirect_back(fallback_location: root_path)
   end
   def checkout
     @categories = Category.all
     @provinces = Province.all
     @order = current_order
     @line_items = @order.line_items
     total = Array.new
     @line_items.each do |item|
       total << item.total
     end
     if user_signed_in?
       @order.user_id = current_user.id
     end
     subtotal = total.reduce(:+)
     @order.subtotal = subtotal.to_f
     @order.save
   end

   def calculate_total
      @provinces = Province.all
       id = params[:id].to_i
       @order = current_order
       if user_signed_in?
         @order.user_id = current_user.id
       end
       user = User.find(@order.user_id)
      #province_id = params[:order][:province_id].to_i
      province_id = user.province_id.to_i
      @order.province_id = province_id
      province = Province.find(province_id)
      gst =  province.gst / 100
      pst =  province.pst / 100
      hst =  province.hst / 100
      shipping = @order.shipping
      subtotal = @order.subtotal
      order_gst = subtotal * gst
      order_pst = subtotal * pst
      order_hst = subtotal * hst
      @order.gst = order_gst
      @order.pst = order_pst
      @order.hst = order_hst
      @order.total =  @order.gst  +  @order.pst + @order.hst + shipping + subtotal
      @order.save
      redirect_to payment_url
   end

   def payment
    @categories = Category.all

    @order = current_order
    @line_items = @order.line_items
    delete_abandoned
   end

   def remove_from_cart
     id = params[:id].to_i
     session[:cart_list].delete(id)
     @order = current_order
  @line_item = @order.line_items.where('product_id =?', params[:id]).first
  @line_item.destroy
  @line_items = @order.line_items
  if @line_items.count == 0
    @order.destroy
    session[:order_id] = nil
  end
  redirect_back(fallback_location: root_path)
   end

   def cart_list
    @categories = Category.all
    @line_items = current_order.line_items
   end

   def update_quantity
      id = params[:id].to_i
      @order = current_order
      @line_item = @order.line_items.find(params[:id])
      quantity = params[:item][:quantity].to_i
      price = params[:item][:price].to_f
      total = quantity * price
      @line_item.update_columns(quantity: quantity, price: price, total: total)
      @line_items = @order.line_items
    redirect_back(fallback_location: root_path)
   end


  def profile
    @categories = Category.all
    @provinces = Province.all
    @user = User.find(current_user.id)
  end

  def save_profile
    @user = User.find(current_user.id)
    name =  params[:name].to_s
    @user.update_columns(name: name)

  end


  private

  def initialize_session

    session[:cart_list] ||= []

  end



   def number_of_cart_items
     @cart_list_count = Product.find(session[:cart_list]).count
   end

   def line_item_params
     params.require(:item).permit(:quantity, :product_id)
  end
   helper_method :cart_list
   helper_method :number_of_cart_items
end
