# frozen_string_literal: true

class Api::PasswordsController < Api::BaseDeviseTransactionsController
  before_action :reset_params

  def reset

    unless reset_params_valid?
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

  def reset_params_valid?
    @error_messages ||= []
    app_valid?
    user_type_valid?
    unless @params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      @error_messages << " #{@params[:email].to_s} não é um endereço válido de email valido"
    end
    @error_messages.blank?
  end

end
