class User < BaseUser

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  belongs_to :organizacao, optional: true
  validates :email ,presence: true, email: true

  has_many :tickets, class_name: "Ticket", foreign_key: 'owner_id'
  has_many :requests, class_name: "Ticket", foreign_key: 'requestor_id'

  def internal?
    organizacao.nil? && self.persisted?
  end

  protected

  def password_required?
    confirmed? ? super : false
  end

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

end
