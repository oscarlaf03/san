class ContaBancaria < ApplicationRecord
  belongs_to :beneficiario
  delegate :organizacao, to: :beneficiario, allow_nil: true

end
