class Api::V1::CondicoesController < Api::V1::BaseController
  before_action :set_condicao, only: [:show, :update]
  before_action :set_organizacao, only: [:create,:index]
  skip_after_action :verify_policy_scoped

  def index
    authorize @organizacao
    @condicoes = Condicao.where(organizacao: @organizacao)
  end

  def show
    authorize @condicao
  end

  def create
    @condicao = @organizacao.condicoes.build(condicao_params)
    authorize @condicao
    if @condicao.save
      render :show, status: :created
    else
      render_error(@condicao)
    end
  end

  def update
    authorize @condicao
    if @condicao.update(condicao_params)
      render :show, status: :created
    else
      render_error(@condicao)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def set_condicao
    @condicao = Condicao.find(params[:id])
  end

  def condicao_params
    params.require(:condicao).permit(*Condicao.params)
  end

end
