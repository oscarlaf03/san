class Ticket < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  delegate :organizacao, to: :requestor, allow_nil: true
  validates :name_model, presence: true, constant: true
  validates :action, presence: true, inclusion: { in: %w( create update destroy),
  message: "%{value} não é uma action valida, as ações validas são: ['create', 'update', 'destroy'] "}
  validates :id_model, numericality:{ only_integer: true},  unless: :is_create_action?
  validates :id_model, absence: true, if: :is_create_action?
  validate :owner_is_internal_user, :requestor_is_organizacao_user, :points_to_an_existent_record

  private

  def is_create_action?
    action  == 'create'
  end

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

  def points_to_an_existent_record
    unless is_create_action?
      begin
        name_model.constantize.find(id_model)
      rescue ActiveRecord::RecordNotFound
        errors.add(:id_model, "O 'id_model':#{id_model} não existe para a clase #{name_model}")
      end
    end
  end

end
