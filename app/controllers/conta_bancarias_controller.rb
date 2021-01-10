class ContaBancariasController < ApplicationController
  before_action :set_conta_bancaria, only: [:show, :edit, :update, :destroy]

  # GET /conta_bancarias
  # GET /conta_bancarias.json
  def index
    @conta_bancarias = ContaBancaria.all
  end

  # GET /conta_bancarias/1
  # GET /conta_bancarias/1.json
  def show
  end

  # GET /conta_bancarias/new
  def new
    @conta_bancaria = ContaBancaria.new
  end

  # GET /conta_bancarias/1/edit
  def edit
  end

  # POST /conta_bancarias
  # POST /conta_bancarias.json
  def create
    @conta_bancaria = ContaBancaria.new(conta_bancaria_params)

    respond_to do |format|
      if @conta_bancaria.save
        format.html { redirect_to @conta_bancaria, notice: 'Conta bancaria was successfully created.' }
        format.json { render :show, status: :created, location: @conta_bancaria }
      else
        format.html { render :new }
        format.json { render json: @conta_bancaria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conta_bancarias/1
  # PATCH/PUT /conta_bancarias/1.json
  def update
    respond_to do |format|
      if @conta_bancaria.update(conta_bancaria_params)
        format.html { redirect_to @conta_bancaria, notice: 'Conta bancaria was successfully updated.' }
        format.json { render :show, status: :ok, location: @conta_bancaria }
      else
        format.html { render :edit }
        format.json { render json: @conta_bancaria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conta_bancarias/1
  # DELETE /conta_bancarias/1.json
  def destroy
    @conta_bancaria.destroy
    respond_to do |format|
      format.html { redirect_to conta_bancarias_url, notice: 'Conta bancaria was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conta_bancaria
      @conta_bancaria = ContaBancaria.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conta_bancaria_params
      params.require(:conta_bancaria).permit(:banco, :codigo_banco, :agencia, :conta, :beneficiario_id)
    end
end
