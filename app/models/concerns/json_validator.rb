class JsonValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    value = value.strip if value.is_a?(String)
    value = value.to_json if value.nil?
    JSON.parse(value)
  rescue =>  exception
    record.errors.add attribute, (options[:message] || "#{attribute} Não é uma string em formato json #{exception.message}")
  end

end

