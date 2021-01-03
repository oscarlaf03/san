class Beneficiario < ApplicationRecord
  resourcify
  rolify

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
end
