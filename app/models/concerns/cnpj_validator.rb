class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CNPJ.valid?(value)
      record.errors.add attribute, (options[:message] || "Não é um CNPJ valido")
    end
  end
end