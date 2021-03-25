class Api::BaseDeviseTransactionsController  < ActionController::API

  private

  def app_valid?
    @error_messages ||= []

    unless @params[:client_id].present? && @params[:client_secret].present?
      @error_messages << "Parâmetros de client_id e client_secret não podem ser nulos"
    end

    app_by_client_id = Doorkeeper::Application.find_by(uid: @params[:client_id])
    app_by_secret = Doorkeeper::Application.find_by(secret: @params[:client_secret])

    unless (app_by_client_id.present? && app_by_secret.present?) && (app_by_client_id == app_by_secret)
      @error_messages << "Parâmetros de client_id e/ou client_secret são inválidos"
    end
    @error_messages.blank?
  end

  def user_type_valid?
    @error_messages ||= []
    unless ['beneficiario','user'].include?(@params[:user_type])
      @error_messages <<  "'user_type' só pode ser 'user' ou 'beneficiario' e não #{@params[:user_type]}" 
    end
  end

  def validate_mandatory_params(*mandatory_params)
    @error_messages ||= []
    mandatory_params.each do |param|
      @error_messages << "O parâmetro: #{param} é obrigatório" unless (@params.include?(param) && !@params[param].nil?)
    end
    @error_messages.blank?
  end

  def render_errors(status_code=400)
    render json: {message: "Problemas no seu chamado", errors: @error_messages}, status: status_code
  end



end
