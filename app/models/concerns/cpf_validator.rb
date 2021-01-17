class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CPF.valid?(value)
      record.errors.add attribute, (options[:message] || "Não é um CPF valido")
    end
  end
end