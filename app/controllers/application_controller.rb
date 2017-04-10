class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

    def current_order
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        Order.new
      end
    end
   @categories = Category.all
    private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
   if resource_or_scope == :user
     new_user_session_path
   elsif resource_or_scope == :admin
     new_admin_session_path
   else
     root_path
   end
   end

end
