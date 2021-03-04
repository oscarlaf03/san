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

  def client_user?
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

  def name
    self.kind_of?(User) ?  "#{self.first_name} #{self.last_name}" :  "#{self.nome} #{self.sobre_nome}"
  end

  def user_type
    if self.kind_of?(User)
      self.client_user? ? 'organizacao' : 'interno'
    elsif self.kind_of?(Beneficiario)
      self.titular? ? 'titular' : 'dependente'
    end
  end

end
