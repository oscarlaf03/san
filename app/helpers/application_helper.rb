module ApplicationHelper

  def login_page?
    ['passwords','registrations','confirmations','sessions','unlocks'].include?(controller_name)
  end

  def login_background_image
    login_page? ? "login-body": ''
  end

  def internal_user?
    current_user.internal?
  end

  def user_logged_in?
    !!current_user or  !!current_beneficiario
  end

  def current_user_or_beneficiario
    user_signed_in? ? current_user : current_beneficiario
  end

  def edit_button
    '<div class="ui icon button blue" data-tooltip="Editar"><i class="edit outline icon"></i></div>'.html_safe
  end

  def back_button
    '<div class="ui icon button blue" data-tooltip="Voltar"><i class="arrow left icon"></i></div>'.html_safe
  end

  def delete_button
    '<div class="ui icon button red" data-tooltip="Excluir"><i class=" white trash alternate icon"></i></div>'.html_safe
  end




end
