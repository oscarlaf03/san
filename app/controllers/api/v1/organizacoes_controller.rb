class Api::V1::OrganizacoesController < Api::V1::BaseController
  before_action :set_organizacao, only:[:show, :update]

  def index
    authorize Organizacao
    @organizacoes = policy_scope(Organizacao)
  end

  def show
    authorize @organizacao
  end

  def create
    @organizacao = Organizacao.new(organizacao_params)
    authorize @organizacao
    if @organizacao.save
      render :show, status: :created
    else
      render_error(@organizacao)
    end
  end

  def update
    authorize @organizacao
    if @organizacao.update(organizacao_params)
      render :show
    else
      render_error(@organizacao)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:id])
  end

  def organizacao_params
    params.require(:organizacao).permit(*Organizacao.params, endereco_attributes: [*Endereco.params, :_destroy])
  end

end
