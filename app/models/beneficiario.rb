class Beneficiario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organizacao
  has_one :titular, class_name: 'Beneficiario', foreign_key: :titular_id
  has_many :dependentes, class_name: 'Beneficiario', foreign_key: :titular_id
end
