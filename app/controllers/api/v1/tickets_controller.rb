class Api::V1::TicketsController < Api::V1::BaseController
  before_action :set_ticket, only: [:show, :update, :delete, :cancel, :execute]

  def index
    authorize Ticket
    @tickets = policy_scope(Ticket)
  end

  def show
    authorize @ticket
  end

  def beneficiarios
    organizacao = Organizacao.find(params[:organizacao_id])
    authorize organizacao
    @tickets = organizacao.requests.select{ |r| r.name_model == "Beneficiario"}
    render :beneficiarios
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.requestor = current_user
    authorize @ticket
    if @ticket.save
      render :show, status: :created
    else
      render_error(@ticket)
    end
  end

  def execute
    authorize @ticket
    if @ticket.execute!
      render :show
    else
      render_error(@ticket)
    end
  end

  def cancel
    authorize @ticket
    if @ticket.cancel!
      render :show
    else
      @ticket.errors.add :canceled, "Não pode cancelar valide a opção"
      render_error(@ticket)
    end
  end



  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(*Ticket.params)
  end

end
