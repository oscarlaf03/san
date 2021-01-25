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

end
