class Api::V1::PlanosController < Api::V1::BaseController
  before_action :set_plano, only: [:show,:update]
  before_action :set_seguradora, only: [:create, :update, :index]

  def index
    @planos = Plano.where(seguradora: @seguradora)
  end

  def show
  end

  def create
    @plano = @seguradora.planos.build(plano_params)
    if @plano.save
      render :show, status: :created
    else
      render_error(@plano)
    end
  end

  def update
    if @plano.update(plano_params)
      render :show, status: :created
    else
      render_error(@plano)
    end
  end

  private

  def set_plano
    @plano = Plano.find(params[:id])
  end

  def set_seguradora
    @seguradora = Seguradora.find(params[:seguradora_id])
  end

  def plano_params
    params.require(:plano).permit(*Plano.params)
  end


end
