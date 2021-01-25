class Beneficiario < BaseUser
  resourcify
  rolify

  validate :titular_nao_pode_ter_titular
  validates :email ,presence: true, email: true
  validates :cpf ,presence: true, cpf: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organizacao
  belongs_to :titular, class_name: 'Beneficiario', foreign_key: :titular_id, optional: true
  has_many :dependentes, class_name: 'Beneficiario', foreign_key: :titular_id, dependent: :destroy
  has_one :beneficio, dependent: :destroy
  has_one :condicao, through: :beneficio
  has_one :organizacao_plano, through: :beneficio
  has_one :plano, through: :organizacao_plano
  has_one :conta_bancaria, dependent: :destroy
  has_one :endereco, dependent: :destroy



  def titular?
    self.titular.nil?
  end

  def perfil
    self.titular? ? 'tiular' : 'dependente'
  end

  private

  def titular_nao_pode_ter_titular
    if self.titular && self.titular.titular
      errors.add(:titular, "Um titular não pode apontar a outro titular")
    end
  end
end
