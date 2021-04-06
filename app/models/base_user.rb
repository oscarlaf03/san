class BaseUser < BaseModel
  self.abstract_class = true


  def sidebar_content
    case self.model_name.name
    when 'User'
      self.internal? ? 'internal_sidebar_content' : 'client_sidebar_content'
    when 'Beneficiario'
      'beneficiario_sidebar_content'
    end
  end

  def internal?
    self.kind_of?(User)  ? self.internal? : false
  end

  def organizacao?
    self.kind_of?(User)  ? self.organizacao.present? : false
  end

  def titular?
    self.kind_of?(Beneficiario)  ? self.titular? : false
  end

  def dependente?
    self.kind_of?(Beneficiario)  ? !self.titular? : false
  end

  def beneficiario?
    self.kind_of?(Beneficiario)
  end

  def user?
    self.kind_of?(User)
  end

  def name
    self.kind_of?(User) ?  "#{self.first_name} #{self.last_name}" :  "#{self.nome} #{self.sobre_nome}"
  end

  def full_name
    name
  end

  def user_scope
    if self.user?
      self.internal? ? 'interno' : 'organizacao'
    elsif self.beneficiario?
      self.titular? ? 'titular' : 'dependente'
    end
  end

  def user_type
    self.user? ? 'user' : 'beneficiario'
  end

  def self.params
    super + [:user_scope, :user_type, :full_name] - [:encrypted_password, :reset_password_token, :reset_password_sent_at , :confirmation_token]
  end

  def confirm_account_url
    "https://san-web-app.herokuapp.com/registrar/#{self.user? ? 'usuario': 'beneficiario'}/#{self.confirmation_token}"
  end

  def reset_password_url
    "https://san-web-app.herokuapp.com/forgot-password/#{self.user? ? 'usuario' : 'beneficiario'}/confirm/#{self.confirmation_token}"
  end

end
