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
                                 :encrypted_password,
                                 :reset_password_token,
                                 :reset_password_sent_at,
                                 :remember_created_at,
                                 :sign_in_count,
                                 :current_sign_in_at,
                                 :last_sign_in_at,
                                 :last_sign_in_ip,
                                 :confirmation_token,
                                 :confirmed_at,
                                 :confirmation_sent_at,
                                 :unconfirmed_email,
                                 :failed_attempts,
                                 :unlock_token,
                                 :locked_at,
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
                                 :encrypted_password,
                                 :reset_password_token,
                                 :reset_password_sent_at,
                                 :remember_created_at,
                                 :sign_in_count,
                                 :current_sign_in_at,
                                 :last_sign_in_at,
                                 :last_sign_in_ip,
                                 :confirmation_token,
                                 :confirmed_at,
                                 :confirmation_sent_at,
                                 :unconfirmed_email,
                                 :failed_attempts,
                                 :unlock_token,
                                 :locked_at,
                                 :created_at,
                                 :updated_at,
                                 :province_id,
                                 :address,
                                 :city,
                                 :postal_code)
  end
end
