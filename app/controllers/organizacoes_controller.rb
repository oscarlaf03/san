class OrganizacoesController < ApplicationController
  before_action :set_organizacao, only: [:show, :edit, :update, :destroy]

  # GET /organizacoes
  # GET /organizacoes.json
  def index
    @organizacoes = policy_scope(Organizacao)
  end

  # GET /organizacoes/1
  # GET /organizacoes/1.json
  def show
    @organizacao = Organizacao.find(params[:id])
    authorize @organizacao
  end

  # GET /organizacoes/new
  def new
    @organizacao = Organizacao.new
    @organizacao.endereco = Endereco.new
    @organizacao.users.build

    authorize @organizacao

  end

  # GET /organizacoes/1/edit
  def edit
    authorize @organizacao
  end

  # POST /organizacoes
  # POST /organizacoes.json
  def create
    @organizacao = Organizacao.new(organizacao_params)
    authorize @organizacao

    respond_to do |format|
      if @organizacao.save
        format.html { redirect_to @organizacao, notice: 'Organizacao was successfully created.' }
        format.json { render :show, status: :created, location: @organizacao }
      else
        format.html { render :new }
        format.json { render json: @organizacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizacoes/1
  # PATCH/PUT /organizacoes/1.json
  def update
    respond_to do |format|
      authorize @organizacao
      if @organizacao.update(organizacao_params)
        format.html { redirect_to @organizacao, notice: 'Organizacao was successfully updated.' }
        format.json { render :show, status: :ok, location: @organizacao }
      else
        format.html { render :edit }
        format.json { render json: @organizacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizacoes/1
  # DELETE /organizacoes/1.json
  def destroy
    authorize @organizacao
    # Not implemented for safety
    
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organizacao
    @organizacao = Organizacao.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def organizacao_params
    params.require(:organizacao).permit(:slug, :razao_social, :cnpj,:nome_fantasia, :inscricao_municipal, :inscricao_estadual,
      endereco_attributes: [:id, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :organizacao_id, :beneficiario_id, :created_at, :updated_at, :_destroy],
      users_attributes: [:id, :email, :organizacao_id, :phone, :first_name, :last_name,:password, :_destroy]
    )
  end
end
