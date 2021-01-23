class BaseUser < ApplicationRecord
  self.abstract_class = true


  def sidebar_content
    case self.model_name.name
    when 'User'
      self.internal? ? 'internal_sidebar_content' : 'client_sidebar_content'
    when 'Beneficiario'
      'beneficiario_sidebar_content'
    end
  end


end