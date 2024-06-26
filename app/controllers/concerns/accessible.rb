# ../controllers/concerns/accessible.rb
module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_beneficiario
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      # redirect_to(rails_admin.dashboard_path) and return
      redirect_to(organizacao_beneficiario_path(current_beneficiario.organizacao, current_beneficiario)) and return
    elsif current_user
      flash.clear
      if current_user.internal?
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(organizacoes_path) and return
      else
        redirect_to(organizacao_path(current_user.organizacao)) and return
      end
    end
  end
end
