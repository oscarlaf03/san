class BaseModel < ApplicationRecord
  self.abstract_class = true

  def self.params
    self.new().attributes.keys.map{ |k| k.to_sym }
  end
end
