class StoreController < ApplicationController
  before_action :initialize_session
  #before_filter :configure_permitted_parameters, if: :devise_controller?
#  attr_accessor :pro
  # before_action :increment_visit_count
  def index
    @categories = Category.all

      @products = Product.order(updated_at: :desc).all.page params[:page]
  @line_item = current_order.line_items.new

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
    #session[:added_to_cart] +=1
    #@cart_items = session[:added_to_cart]
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
    # session[:visit_count] += 1
    # @visit_count = session[:visit_count]


    # product = Product.find(session[:cart_list])
    #
    # product.each do |item|
    #   LineItem.create(product_id: item.id, price: item.price, quantity: 1, total: item.price, session: request.session.id )
    # end

    # items = LineItem.find(session[:cart_list])
    #
    #   items.each do |item|
    #     LineItem.create(product_id: item.product.id, price: item.product.price, quantity: 1,
    #      total: item.price, session: request.session.id )
    #   end

#  end
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
      province_id = params[:order][:province_id].to_i
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
    #  line = LineItem.where('product_id = ?', id)
    #  line.each do |item|
    #    if item.session == request.session.id
    #      item.destroy
    #    end
    #  end
    #  redirect_back(fallback_location: root_path)
   end

   def cart_list
    @categories = Category.all
    @line_items = current_order.line_items
    # @line_item = Array.new
    # id = params[:id].to_i
    # line = LineItem.where('session = ?', request.session.id)
    # line.each do |item|
    #   if item.session == request.session.id
    #     @product = Product.find(session[:cart_list])
    #
    #     @product.each do |pro|
    #       pro.quantity = item.quantity
    #       @pro = pro.quantity
    #
    #     end
    #     return @product
    #   end
  # end
     #session[:cart_list].each do |id|
    #  @line_item << LineItem.where('product_id = ?', id)
    # end
  #   return @line_item
#  Product.find(session[:cart_list])
#  LineItem.where(product_id: [session[:cart_list]])
    # line_item = LineItem.all
    #
    # line_item.each do |item|
    #   if item.session == request.session.id
    #     @line_item =  LineItem.where('product_id = ?', session[:cart_list])
    #   end
    #
    #   return @line_item
    #LineItem.where('product_id = ?', session[:cart_list]).where('session = ?', request.session.id)
    #LineItem.where('session = ?', request.session.id).where(product_id: [session[:cart_list]]) kvelas achvenebs

  #  line_item = LineItem.where('session = ?', request.session.id).where(product_id: [session[:cart_list]]).group('id')

    # line_item.each do |item|
    #   @line = Product.find(item.product_id)
    # end

    #return @line

    #LineItem.find(:conditions => ['product_id = ?', session[:cart_list]]).first
    #end
    #LineItem.find(:all, :conditions => ['product_id = ?', session[:cart_list]])
    # product = Product.find(session[:cart_list])
    #
    #  product.each do |item|
    #    item.update_columns(quantity: 1)
    #  end

   end

   def update_quantity
     id = params[:id].to_i
     #@line_item = LineItem.find(params[:id])
    #  @line_item = LineItem.where('product_id = ?', params[:id]).first
    # # if @line_item.session == request.session.id
    #   @line_item.quantity = params[:item][:quantity]
    #    @line_item.update_columns(quantity: @line_item.quantity)
  #   end
    #  @line_item.each do |item|
    #    if item.session == request.session.id
        # item.quantity = 6
      #    item.update_columns(quantity: item.product.quantity)
    #      #item.save
    #    end
  #    end
  #  @line_item = Product.find(params[:id])
  #  @line_item.quantity = params[:item][:quantity]
  #  @line_item.update_columns(quantity: @line_item.quantity)
      @order = current_order
      @line_item = @order.line_items.find(params[:id])
    #  @line_item.quantity = params[:item][:quantity]

      quantity = params[:item][:quantity].to_i
      price = params[:item][:price].to_f
      total = quantity * price
      @line_item.update_columns(quantity: quantity, price: price, total: total)
      @line_items = @order.line_items
    redirect_back(fallback_location: root_path)
   end

  # def sign_out
  #     redirect_back(fallback_location: root_path)
  # end

  def profile
    @categories = Category.all
    @provinces = Province.all
    @user = User.find(current_user.id)
  end

  def save_profile
    @user = User.find(current_user.id)
    #@user.name = params[:name].to_s
    name =  params[:name].to_s
    @user.update_columns(name: name)
  #  @user.save
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

   def line_item_params
     params.require(:item).permit(:quantity, :product_id)
  end
  # def configure_permitted_parameters
  #    devise_parameter_sanitizer.for(:account_update) << :name ## add the attributes you want to permit
  # end
   helper_method :cart_list
   helper_method :number_of_cart_items
end
