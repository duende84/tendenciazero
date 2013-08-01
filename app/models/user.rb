# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password        :string(255)
#  user_type_id    :integer
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :user_type_id, :user_type, :password_confirmation

  attr_accessor :skip_password_validation

  belongs_to :user_type, :foreign_key => "user_type_id"

  has_secure_password

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50, minimum: 3 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, :presence => true, length: { minimum: 6 }, :unless => :skip_password_validation
  validates :password_confirmation, presence: true, :unless => :skip_password_validation



  def custom_update_attributes(params)
    if params[:password].blank?
      params.delete :password
      params.delete :password_confirmation
      update_attributes params
    end
  end

  def admin?
    if (self.user_type == UserType.find_by_name('Admin')) && (self.user_type!= nil)
      return true
    else
      return false
    end
  end  

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
