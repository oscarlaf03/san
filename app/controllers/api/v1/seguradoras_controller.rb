class Api::V1::SeguradorasController < Api::V1::BaseController
  before_action :set_seguradora, only:[:show, :update]

  def index
    @seguradoras = Seguradora.all
  end

  def show
  end

  def create
    @seguradora = Seguradora.new(seguradora_params)
    if @seguradora.save
      render :show, status: :created
    else
      render_error(@seguradora)
    end
  end

  def update
    if @seguradora.update(seguradora_params)
      render :show, status: :created
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
