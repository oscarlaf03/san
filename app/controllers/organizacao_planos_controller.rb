class OrganizacaoPlanosController < ApplicationController
  before_action :set_organizacao, only: [:new, :create, ]

  def new
    @planos = Plano.all - @organizacao.planos
    @organizacao_plano =  OrganizacaoPlano.new(organizacao: @organizacao)
    authorize @organizacao_plano
  end

  def create
    @organizacao_plano = OrganizacaoPlano.new(organizacao_plano_params)
    @organizacao_plano.organizacao = @organizacao
    authorize @organizacao_plano
    if @organizacao_plano.save
      redirect_to organizacao_path(@organizacao)
    else
      # TODO render error
      format.html
    end
  end

  def destroy
    @organizacao_plano = OrganizacaoPlano.find(params[:id])
    org = @organizacao_plano.organizacao
    authorize @organizacao_plano
    @organizacao_plano.destroy
    redirect_to organizacao_path(org)
  end

  private

  def set_organizacao
    @organizacao = Organizacao.find(params[:organizacao_id])
  end

  def organizacao_plano_params
    params.require(:organizacao_plano).permit(OrganizacaoPlano.params)
  end

end
