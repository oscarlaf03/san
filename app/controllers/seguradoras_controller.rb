class SeguradorasController < ApplicationController
  before_action :set_seguradora, only: [:show, :edit, :update, :destroy]

  # GET /seguradoras
  # GET /seguradoras.json
  def index
    @seguradoras = Seguradora.all
  end

  # GET /seguradoras/1
  # GET /seguradoras/1.json
  def show
  end

  # GET /seguradoras/new
  def new
    @seguradora = Seguradora.new
  end

  # GET /seguradoras/1/edit
  def edit
  end

  # POST /seguradoras
  # POST /seguradoras.json
  def create
    @seguradora = Seguradora.new(seguradora_params)

    respond_to do |format|
      if @seguradora.save
        format.html { redirect_to @seguradora, notice: 'Seguradora was successfully created.' }
        format.json { render :show, status: :created, location: @seguradora }
      else
        format.html { render :new }
        format.json { render json: @seguradora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seguradoras/1
  # PATCH/PUT /seguradoras/1.json
  def update
    respond_to do |format|
      if @seguradora.update(seguradora_params)
        format.html { redirect_to @seguradora, notice: 'Seguradora was successfully updated.' }
        format.json { render :show, status: :ok, location: @seguradora }
      else
        format.html { render :edit }
        format.json { render json: @seguradora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seguradoras/1
  # DELETE /seguradoras/1.json
  def destroy
    @seguradora.destroy
    respond_to do |format|
      format.html { redirect_to seguradoras_url, notice: 'Seguradora was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seguradora
      @seguradora = Seguradora.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seguradora_params
      params.require(:seguradora).permit(:cnpj, :razao_social, :nome)
    end
end
