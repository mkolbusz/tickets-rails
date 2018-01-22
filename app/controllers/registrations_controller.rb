class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:date_of_birth, :name, :email, :password, :password_confirmation, :address, :phone)
    end

    def account_update_params
        params.require(:user).permit(:date_of_birth, :name, :email, :password, :password_confirmation, :current_password, :address, :phone)
    end
end
