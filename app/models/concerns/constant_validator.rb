class ConstantValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      value.constantize
    rescue
      record.errors.add attribute, (options[:message] || "#{value} Não é um nome valido para #{attribute}")
    end

  end

end
