class RegistrationsController < Devise::RegistrationsController
   def show
     @categories = Category.all
   end

  private

  def sign_up_params
    @categories = Category.all
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :current_password,
                                 :created_at,
                                 :updated_at,
                                 :province_id,
                                 :address,
                                 :city,
                                 :postal_code)
  end

  def account_update_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :current_password,
                                 :created_at,
                                 :updated_at,
                                 :province_id,
                                 :address,
                                 :city,
                                 :postal_code)
  end
end
