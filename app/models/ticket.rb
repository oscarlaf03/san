class Ticket < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  delegate :organizacao, to: :requestor, allow_nil: true

end
