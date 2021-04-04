class Api::V1::BeneficiosController < Api::V1::BaseController
  before_action :set_organizacao, only: [:index]
  before_action :set_beneficio, only: [:show, :update]
  skip_after_action :verify_policy_scoped

  def index
    authorize @organizacao
    @beneficios = @organizacao.beneficios
  end

  def show
    authorize @beneficio
  end

  def create
    @beneficio = Beneficio.new(beneficio_params)
    authorize @beneficio
    if @beneficio.save
      render :show, status: :created
    else
      render_error(@beneficio)
    end
  end

  def update
    authorize @beneficio
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
