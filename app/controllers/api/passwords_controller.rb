# frozen_string_literal: true

class Api::PasswordsController < ActionController::API
  # before_action :doorkeeper_authorize!
  before_action :reset_params

  def reset

    unless params_valid?
      return render_errors
    end

    if @params[:user_type] == 'user'
      @user = User.find_by(email: @params[:email])
    elsif @params[:user_type] == 'beneficiario'
      @user = Beneficiario.find_by(email: @params[:email])
    end

    unless @user
      @error_messages << "Não existe usuário de tipo \"#{@params[:user_type]}\" e email: \"#{@params[:email]}\""
      return render_errors
    end

    if @user.send_reset_password_instructions
      return render json: {message: "Instruções para resetar senha enviadas com sucesso ao email: #{@params[:email]}"}
    else
      return render json: {message: "Problemas com seu chamado, senha não reseteada"}, status: 500
    end
  end

  private

  def reset_params
    @params = params.permit(:email,:user_type, :client_id, :client_secret)
  end

  def params_valid?
    @error_messages = []
    unless ['beneficiario','user'].include?(@params[:user_type])
      @error_messages <<  "'user_type' só pode ser 'user' ou 'beneficiario' e não #{@params[:user_type]}" 
    end

    unless @params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      @error_messages << " #{@params[:email].to_s} não é um endereço válido de email valido"
    end

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

  def render_errors
    render json: {message: "Problemas no seu chamado", errors: @error_messages}, status: 400
  end


end
