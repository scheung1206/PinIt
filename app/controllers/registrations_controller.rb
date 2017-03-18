class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
   params.require(:user).permit(:FirstName, :LastName,:email, :password, :password_confirmation, :premium)
 end

 def account_update_params
   params.require(:user).permit(:FirstName, :LastName, :email, :password, :password_confirmation, :current_password, :premium)
end
end
