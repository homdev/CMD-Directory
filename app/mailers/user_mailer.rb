class UserMailer < ApplicationMailer
    def profile_updated_email
      @user = params[:user]
      mail(to: @user.email, subject: "Votre profil a été mis à jour")
    end
  
    def error_notification_email
      @user = params[:user]
      @error_message = params[:error_message]
      mail(to: @user.email, subject: "Erreur lors de la mise à jour de votre profil")
    end
  
    def image_uploaded_email
      @user = params[:user]
      @image_type = params[:image_type]
      mail(to: @user.email, subject: "Votre image a été téléchargée")
    end
end
  