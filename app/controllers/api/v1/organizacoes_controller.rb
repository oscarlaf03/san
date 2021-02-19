class Api::V1::OrganizacoesController < Api::V1::BaseController
  before_action :set_organizacao, only:[:show, :update]

  def index
    @organizacoes = Organizacao.all
  end

  def show
  end

  def create
    @organizacao = Organizacao.new(organizacao_params)
    if @organizacao.save
      render :show, status: :created
    else
      render_error(@organizacao)
    end
  end

  def update
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
    params.require(:organizacao).permit(*Organizacao.params)
  end

end
