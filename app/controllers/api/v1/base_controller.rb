class Api::V1::BaseController < ActionController::API
  include Pundit
  before_action :doorkeeper_authorize!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized



  def render_error(instance)
    render json: { errors: instance.errors.full_messages },
      status: :unprocessable_entity
  end

  private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end

    def user_not_authorized
      render json: {message: "Not authorized"}, status: :forbidden
    end

end
