class Beneficio < ApplicationRecord
  belongs_to :beneficiario
  belongs_to :organizacao_plano
end
