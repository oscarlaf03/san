class OrganizacaoUsersController  < ApplicationController
  before_action :set_organizacao , only: [:index, :create]
  before_action :set_user, only:[:show, :edit, :upate]
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @users = @organizacao.users
  end

  def edit 
    authorize @user

  end

  def create
    @user = @organizacao.users.build(user_params)
    if @user.save
      format.html { redirect_to  organizacao_user_path(@organizacao, @user), notice: 'Organizacao was successfully created.' }

      render template: 'api/v1/users/show', status: :created
    else
      render_error(@user)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:organizacao_user).permit(*User.params)
  end

end
