class Seguradora < ApplicationRecord
  has_many :planos, dependent: :destroy
end
