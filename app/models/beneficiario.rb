class Beneficiario < ApplicationRecord
  resourcify
  rolify

  validate :titular_nao_pode_ter_titular

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organizacao
  belongs_to :titular, class_name: 'Beneficiario', foreign_key: :titular_id, optional: true
  has_many :dependentes, class_name: 'Beneficiario', foreign_key: :titular_id


  def perfil
    self.titular ? 'dependente' : 'titular'
  end

  private

  def titular_nao_pode_ter_titular
    if self.titular && self.titular.titular
      errors.add(:titular, "Um titular não pode apontar a outro titular")
    end
  end
end
