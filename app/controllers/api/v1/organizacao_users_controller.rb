class Api::V1::OrganizacaoUsersController < Api::V1::BaseController
  before_action :set_organizacao , only: [:index, :create]
  skip_after_action :verify_policy_scoped

  def index
    authorize @organizacao
    @users = @organizacao.users
  end

  def create
    @user = @organizacao.users.build(user_params)
    authorize @user
    if @user.save
      render template: 'api/v1/users/show', status: :created
    else
      render_error(@user)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def user_params
    params.require(:organizacao_user).permit(*User.params)
  end

end
