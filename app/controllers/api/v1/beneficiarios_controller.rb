class Api::V1::BeneficiariosController < Api::V1::BaseController
  before_action :set_beneficiario, only: [:show,:update]
  before_action :set_organizacao, only: [:create, :update, :index]
  skip_after_action :verify_policy_scoped

  def index
    authorize @organizacao
    @beneficiarios = Beneficiario.where(organizacao: @organizacao)
  end

  def show
    authorize @beneficiario
  end

  def create
    @beneficiario = @organizacao.beneficiarios.build(beneficiario_params)
    authorize @beneficiario
    if @beneficiario.save
      render :show, status: :created
    else
      render_error(@beneficiario)
    end
  end

  def update
    authorize @beneficiario
    if @beneficiario.update(beneficiario_params)
      render :show, status: :created
    else
      render_error(@beneficiario)
    end
  end

  private

  def set_beneficiario
    @beneficiario = Beneficiario.find(params[:id])
  end

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def beneficiario_params
    params.require(:beneficiario).permit(*Beneficiario.params)
  end

end
