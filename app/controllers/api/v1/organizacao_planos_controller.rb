class Api::V1::OrganizacaoPlanosController < Api::V1::BaseController
  before_action :set_organizacao_plano , only: [:show, :update]
  before_action :set_organizacao, only: [:index,:create, :update]

  def index
    @organizacao_planos = OrganizacaoPlano.where(organizacao: @organizacao)
  end

  def show
  end

  def create
    @organizacao_plano = @organizacao.organizacao_planos.build(organizacao_plano_params)
    if @organizacao_plano.save
      render :show, status: :created
    else
      render_error(@organizacao_plano)
    end
  end

  def update
    if @organizacao_plano.update(organizacao_plano_params)
      render :show
    else
      render_error(@organizacao_plano)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def set_organizacao_plano
    @organizacao_plano = OrganizacaoPlano.find(params[:id])
  end

  def organizacao_plano_params
    params.require(:organizacao_plano).permit(:plano_id)
  end

end
