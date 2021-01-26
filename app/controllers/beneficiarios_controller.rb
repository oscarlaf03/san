class BeneficiariosController < ApplicationController
  before_action :set_beneficiario, only: [:show, :edit, :update, :destroy]
  # include Accessible
  # skip_before_action :check_user, only: [:destroy,:show]

  def index
    @beneficiarios = policy_scope(Beneficiario)
  end

  def show
    # skip_authorization
    authorize @beneficiario
  end

  def new
    @beneficiario = Beneficiario.new
    authorize @beneficiario
  end

  def edit
    authorize @beneficiario
  end

  def create
    @beneficiario = Beneficiario.new(beneficiario_params)
    authorize @beneficiario

    respond_to do |format|
      if @beneficiario.save
        format.html { redirect_to @beneficiario, notice: 'beneficiario was successfully created.' }
        format.json { render :show, status: :created, location: @beneficiario }
      else
        format.html { render :new }
        format.json { render json: @beneficiario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      authorize @beneficiario
      if @beneficiario.update(beneficiario_params)
        format.html { redirect_to @beneficiario, notice: 'Beneficiario was successfully updated.' }
        format.json { render :show, status: :ok, location: @beneficiario }
      else
        format.html { render :edit }
        format.json { render json: @beneficiario.errors, status: :unprocessable_entity }
      end
    end
  end

  private  
  
  def set_beneficiario
    @beneficiario = Beneficiario.find(params[:id])
  end

  def beneificario_params
    attributes = [:id,
    :email,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :nome,
    :nacionalidade,
    :cpf,
    :sexo,
    :data_nascimento,
    :estado_civil,
    :nome_da_mae,
    :telefone,
    :cargo,
    :admissao,
    :salario,
    :papel,
    :organizacao_id,
    :created_at,
    :updated_at,
    :titular_id]
    params.require(:beneficiario).permit(*attributes)
  end


end
