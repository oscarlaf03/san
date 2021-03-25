class Api::ConfirmationsController <  Api::BaseDeviseTransactionsController
  before_action :confirmation_params

  def confirm

    unless confirmation_valid_params?
      return render_errors
    end

    case @params[:user_type]
      when 'user'
        @user = User.confirm_by_token(@params[:token])
      when 'beneficiario'
        @user = Beneficiario.confirm_by_token(@params[:token])
    end

    unless @user && @user.confirmed?
      @error_messages << "Esse token não corresponde a nehum usuário ou já foi utilizado"
      return render_errors
    end

    if @user.update(password: @params[:password], password_confirmation: @params[:password_confirmation])
      return render json: {message: "Conta  e senha de #{@user.name} com email #{@user.email} confirmadas com sucesso"}
    else
      @error_messages << "Tivemos problemas com a sua solicitação verifique todas as informações enviadas ou entre em contato com suporte"
      return render_errors(500)
    end

  

  end

  private

  def confirmation_params
    @params = params.permit(:email,:user_type, :client_id, :client_secret, :token, :password, :password_confirmation)
  end

  def confirmation_valid_params?
    @error_messages ||= []
    validate_mandatory_params(:token,:password,:password_confirmation)
    user_type_valid?
    app_valid?
    unless @params[:password] == @params[:password_confirmation]
      @error_messages << "password e password_confirmation têm que ser iguais"
    end
    @error_messages.blank?
  end

end
