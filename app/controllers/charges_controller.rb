class ChargesController < ApplicationController
  def new
    @categories = Category.all
   @amount = current_order.total # $5 in cents
   @description = 'Description of Charge'

    redirect_back(fallback_location: root_path)
 end

 def index
   @cateogires = Category.all
   redirect_back (fallback_location: root_path)
 end

 def create
   @categories = Category.all
   amount = 500 # $5 in cents

   @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                      source: params[:stripeToken])

   @charge = Stripe::Charge.create(customer:    @customer.id,
                                   amount:      amount,
                                   description: 'Rails Stripe customer',
                                   currency:    'cad')
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end
redirect_back(fallback_location: store_index_path)
end
