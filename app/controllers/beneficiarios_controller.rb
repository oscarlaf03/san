class BeneficiariosController < ApplicationController
  before_action :set_beneficiario, only: [:show, :edit, :update, :destroy]
  # include Accessible
  # skip_before_action :check_user, only: [:destroy,:show]

  def index
  end

  def show
    # skip_authorization
    authorize @beneficiario
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  private  
  
  def set_beneficiario
    @beneficiario = Beneficiario.find(params[:id])
  end

end
