class Api::V1::BeneficiosController < Api::V1::BaseController
  before_action :set_organizacao, only: [:index]
  before_action :set_beneficio, only: [:show, :update]

  def index
    @beneficios = @organizacao.beneficios
  end

  def show
  end

  def create
    @beneficio = Beneficio.new(beneficio_params)
    if @beneficio.save
      render :show, status: :created
    else
      render_error(@beneficio)
    end
  end

  def update
    if @beneficio.update(beneficio_params)
      render :show
    else
      render_error(@beneficio)
    end
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def set_beneficio
    @beneficio = Beneficio.find(params[:id])
  end

  def beneficio_params
    params.require(:beneficio).permit(*Beneficio.params, beneficio_condicao_attributes:[*BeneficioCondicao.params, :_destroy])
  end
end
