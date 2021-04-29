class Ticket < BaseModel
  # belongs_to :organizacao, optional: true
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  validates :name_model, presence: true, constant: true
  validates :action, presence: true, inclusion: { in: %w( create update destroy),
  message: "%{value} não é uma action valida, as ações validas são: ['create', 'update', 'destroy'] "}
  validates :id_model, numericality:{ only_integer: true},  unless: :is_create_action?
  validates :id_model, absence: true, if: :is_create_action?
  validates :data_vigor, presence: true
  validates :params, presence: true, json: true,  unless: :is_destroy_action?
  validate :owner_is_internal_user, :requestor_is_organizacao_user, :points_to_allowed_org_record, :can_execute, :valid_organizacao_id_in_params
  delegate :organizacao, to: :requestor

    #TODO 
    # validate ticket uniqueness

  def execute!
    return true if executed
    case action
    when 'update'
       if instance.update(**parsed_params)
        close_executed
       else
        copy_errors_from_instance
        false
       end
    when 'create'
      element = constant.new(**parsed_params)
      if element.attributes.keys.include?('organizacao_id')
        #TODO adicionar organizacao_id dentro do ticket?? ccomo controlar isso? precissa issto?
        # element.organizacao_id = self.organizacao.id #não passar a org do ticket por em quanto
      end
      if element.save
        close_executed
      else
        copy_errors_from_instance
        false
      end
    when 'destroy'
       if instance.destroy
        close_executed
       else
        copy_errors_from_instance
        false
       end
    end
  end

  def cancel!
    return true if canceled
    self.update(canceled: true, open: false, closed_at: DateTime.now)
  end


  private

  def is_create_action?
    action == 'create'
  end

  def is_destroy_action?
    action == 'destroy'
  end

  def constant
    name_model.constantize
  rescue
  end

  def instance
    constant.find(id_model) if constant
  rescue ActiveRecord::RecordNotFound
    msg = "O 'id_model':#{id_model} não existe para a clase #{name_model}"
    unless errors.details[:id_model].present? && errors.details[:id_model].first[:error] == msg
      errors.add(:id_model, msg )
    end
  end

  def close_executed
    self.update(open: false, executed: true, closed_at: DateTime.now)
  end

  def parsed_params
    unless is_destroy_action?
      begin
        JSON.parse(params).deep_symbolize_keys!
      rescue
      end
    end
  end

  def valid_organizacao_id_in_params
    unless parsed_params.nil? || !parsed_params.has_key?(:organizacao_id)
      unless requestor.org_group_ids.include?(parsed_params[:organizacao_id])
        errors.add(:params, "a 'organizacao_id':#{parsed_params[:organizacao_id]} passada no params esta fora do grupo de organizações deste usuário")
      end
    end
  end

  def copy_errors_from_instance(object=instance)
    errors.add( :params, object.errors.messages.to_s) if object
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

  def points_to_allowed_org_record
    unless is_create_action?
      if instance.kind_of?(Organizacao)
        errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} pertence a uma Organizacão que esta fora do grupo de organizações do seu usuário") unless  self.requestor.org_group.include?(instance)
      elsif instance.respond_to?(:organizacao)
        errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} pertence a uma Organizacão que esta fora do grupo de organizações do seu usuário") unless self.requestor.org_group.include?(instance.organizacao)
      elsif instance.present?
        errors.add(:id_model, "O 'id_model':#{id_model} para  #{name_model} não response ao método de Organizacao falar com suporte técnico")
      end
    end
  end

  def can_execute
    unless is_destroy_action?
      case action
      when 'create'
        object = constant.new(**parsed_params) if constant && parsed_params
        unless object && object.valid?
          copy_errors_from_instance(object)
        end
      when 'update'
        object = instance.assign_some_attributes(**parsed_params) if instance && parsed_params
        unless object && object.valid?
          copy_errors_from_instance(object)
        end
      end
    end
  end

end
