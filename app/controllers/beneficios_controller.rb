class BeneficiosController < ApplicationController
  before_action :set_beneficio, only: [:show, :edit, :update, :destroy]

  # GET /beneficios
  # GET /beneficios.json
  def index
    @beneficios = Beneficio.all
  end

  # GET /beneficios/1
  # GET /beneficios/1.json
  def show
  end

  # GET /beneficios/new
  def new
    @beneficio = Beneficio.new
  end

  # GET /beneficios/1/edit
  def edit
  end

  # POST /beneficios
  # POST /beneficios.json
  def create
    @beneficio = Beneficio.new(beneficio_params)

    respond_to do |format|
      if @beneficio.save
        format.html { redirect_to @beneficio, notice: 'Beneficio was successfully created.' }
        format.json { render :show, status: :created, location: @beneficio }
      else
        format.html { render :new }
        format.json { render json: @beneficio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beneficios/1
  # PATCH/PUT /beneficios/1.json
  def update
    respond_to do |format|
      if @beneficio.update(beneficio_params)
        format.html { redirect_to @beneficio, notice: 'Beneficio was successfully updated.' }
        format.json { render :show, status: :ok, location: @beneficio }
      else
        format.html { render :edit }
        format.json { render json: @beneficio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beneficios/1
  # DELETE /beneficios/1.json
  def destroy
    @beneficio.destroy
    respond_to do |format|
      format.html { redirect_to beneficios_url, notice: 'Beneficio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beneficio
      @beneficio = Beneficio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beneficio_params
      params.require(:beneficio).permit(:Beneficiario_id, :OrganizacaoPlano_id)
    end
end
