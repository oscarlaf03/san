class User < BaseUser

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  belongs_to :organizacao, optional: true
  validates :email ,presence: true, email: true

  def internal?
    organizacao.nil? && self.persisted?
  end

  protected
  
  def password_required?
    confirmed? ? super : false
  end

end
