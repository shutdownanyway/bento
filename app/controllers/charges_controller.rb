class ChargesController < ApplicationController
  def new
#    @categories = Category.all
   @amount = dollars_to_cents(current_order.total) # $5 in cents
   @description = 'Description of Charge'

  #  redirect_back(fallback_location: root_path)
 end

 def index
   @cateogires = Category.all
   redirect_to  root_path
 end

 def create
   @categories = Category.all

   @amount = dollars_to_cents(current_order.total) # $5 in cents
   order = current_order.id


   @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                      source: params[:stripeToken])

   @charge = Stripe::Charge.create(customer:    @customer.id,
                                   amount:      @amount,
                                   description: "Order ##{order}",
                                   currency:    'cad')
   if @charge.paid && @charge.amount == dollars_to_cents(current_order.total)
    #
     order = current_order
     order.update_columns(order_status_id: 2, stripe_charge_id: @charge.id)
       session[:cart_list].clear
        session[:order_id] = nil
    if current_user.stripe_customer_id.nil?
      customer = current_user
      customer.update_columns(stripe_customer_id: @customer.id)
    end
   end

 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path


 end
 private
    def dollars_to_cents(dollars)

   (100 * dollars.round(2).to_r).to_i
 end

end
