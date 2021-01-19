class ApplicationController < ActionController::Base
  before_action :authenticate!
  include Pundit

   # Pundit: white-list approach.
   after_action :verify_authorized, except: :index, unless: :skip_pundit?
   after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

   # Uncomment when you *really understand* Pundit!
   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
   def user_not_authorized
     flash[:alert] = "Ação não autorizada"
     redirect_to(root_path)
   end
   private
   def skip_pundit?
     devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
   end

   def authenticate!
      :authenticate_user! or :authenticate_beneficiario!
      @current_user =  user_signed_in? ? current_user : current_beneficiario
   end
end
