class Ticket < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  delegate :organizacao, to: :requestor, allow_nil: true
  validates :name_model, presence: true, constant: true
  validates :action, presence: true, inclusion: { in: %w( create update delete),
  message: "%{value} não é uma action valida"}
  validates :id_model, presence: true, numericality: { only_integer: true }
  validate :owner_is_internal_user, :requestor_is_organizacao_user

  private

  def owner_is_internal_user
    if owner.present? && !owner.internal?
      errors.add(:owner, "Só pode ser um usuário interno")
    end
  end

  def requestor_is_organizacao_user
    if requestor.present? && !requestor.organizacao?
      errors.add(:requestor, "Só pode ser um usuário organizacao")
    end
  end

end
