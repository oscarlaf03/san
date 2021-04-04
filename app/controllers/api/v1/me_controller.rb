class Api::V1::MeController < Api::V1::BaseController
  skip_after_action  :verify_authorized, only:  [:me]

  def me
    if current_user.user?
      @user = current_user
      render template: 'api/v1/users/show'
    elsif current_user.beneficiario?
      @beneficiario = current_user
      render template: 'api/v1/beneficiarios/show'
    else
      render json:{message: 'error'}, status: :bad_request
    end
  end


end
