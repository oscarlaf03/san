class Api::V1::BaseController < ActionController::API
  include Pundit
  before_action :doorkeeper_authorize!
  after_action :verify_authorized #, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :authorization_not_performed


  def render_error(instance)
    render json: { errors: instance.errors.full_messages },
      status: :unprocessable_entity
  end

  private

    # helper method to access the current user from the token
    def current_user
      case doorkeeper_token.model_user_type
      when 'user'
        @current_user = User.find_by(id: doorkeeper_token[:resource_owner_id]) || Beneficiario.find_by(id: doorkeeper_token[:resource_owner_id])
      when 'beneficiario'
        @current_user = Beneficiario.find_by(id: doorkeeper_token[:resource_owner_id])
      end
    end

    def user_not_authorized
      render json: {message: "Not authorized"}, status: :forbidden
    end

    def authorization_not_performed
      render json: {message: "Need to call poundit authorize method on record"}, status: :forbidden
    end

end
