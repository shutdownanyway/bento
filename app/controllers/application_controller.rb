class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :delete_abandoned
     before_action :configure_permitted_parameters, if: :devise_controller?

    def current_order
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        Order.new
      end
    end
   @categories = Category.all

  def delete_abandoned
    line_items = LineItem.where("created_at < ?", 1.day.ago)
    line_items.each do |item|
      order = Order.find(item.order_id)
      if order.order_status_id == 1
        item.destroy
      end
    end
  end


 protected

 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:account_updat) do |user_params|
    user_params.permit(:name, :email)
  end
end
    private

  # Overwriting the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #  if resource_or_scope == :user
  #    new_user_session_path
  #  elsif resource_or_scope == :admin
  #    new_admin_session_path
  #  else
  #    root_path
  #  end
  #  end

   def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
