class AseguradorasController < ApplicationController
  before_action :set_aseguradora, only: [:show, :edit, :update, :destroy]

  # GET /aseguradoras
  # GET /aseguradoras.json
  def index
    @aseguradoras = Aseguradora.all
  end

  # GET /aseguradoras/1
  # GET /aseguradoras/1.json
  def show
  end

  # GET /aseguradoras/new
  def new
    @aseguradora = Aseguradora.new
  end

  # GET /aseguradoras/1/edit
  def edit
  end

  # POST /aseguradoras
  # POST /aseguradoras.json
  def create
    @aseguradora = Aseguradora.new(aseguradora_params)

    respond_to do |format|
      if @aseguradora.save
        format.html { redirect_to @aseguradora, notice: 'Aseguradora was successfully created.' }
        format.json { render :show, status: :created, location: @aseguradora }
      else
        format.html { render :new }
        format.json { render json: @aseguradora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aseguradoras/1
  # PATCH/PUT /aseguradoras/1.json
  def update
    respond_to do |format|
      if @aseguradora.update(aseguradora_params)
        format.html { redirect_to @aseguradora, notice: 'Aseguradora was successfully updated.' }
        format.json { render :show, status: :ok, location: @aseguradora }
      else
        format.html { render :edit }
        format.json { render json: @aseguradora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aseguradoras/1
  # DELETE /aseguradoras/1.json
  def destroy
    @aseguradora.destroy
    respond_to do |format|
      format.html { redirect_to aseguradoras_url, notice: 'Aseguradora was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aseguradora
      @aseguradora = Aseguradora.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def aseguradora_params
      params.fetch(:aseguradora, {})
    end
end
