class BaseModel < ApplicationRecord
  self.abstract_class = true

  def self.params
    self.new().attributes.keys.map{ |k| k.to_sym }
  end

  def assign_some_attributes(**args)
    attrs = self.attributes
    args.each{ |key, value| attrs[key.to_s]=value}
    self.assign_attributes(attrs)
    self
  end
end
