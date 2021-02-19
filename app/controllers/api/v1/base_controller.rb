class Api::V1::BaseController < ActionController::API

  def render_error(instance)
    render json: { errors: instance.errors.full_messages },
      status: :unprocessable_entity
  end

end
