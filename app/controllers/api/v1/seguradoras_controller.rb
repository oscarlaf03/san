class Api::V1::SeguradorasController < Api::V1::BaseController
  before_action :set_seguradora, only:[:show, :update]

  def index
    authorize Seguradora
    @seguradoras = policy_scope(Seguradora)
  end

  def show
    authorize @seguradora
  end

  def create
    @seguradora = Seguradora.new(seguradora_params)
    authorize @seguradora
    if @seguradora.save
      render :show, status: :created
    else
      render_error(@seguradora)
    end
  end

  def update
    authorize @seguradora
    if @seguradora.update(seguradora_params)
      render :show
    else
      render_error(@seguradora)
    end
  end

  private

  def set_seguradora
    @seguradora = Seguradora.find(params[:id])
  end

  def seguradora_params
    params.require(:seguradora).permit(*Seguradora.params)
  end
 
end
