class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :authenticatable
  has_many :documents

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  def active_for_authentication?
    super && self.is_active?
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end
 
  protected
 
  def password_required?
    return false if skip_password_validation
    super
  end
end
