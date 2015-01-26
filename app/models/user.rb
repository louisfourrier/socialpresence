# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  ##-- Constants--------------------
  
  ##-- Virtual Attributes ----------
  
  ##-- Validations -----------------
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
 
  
  ##-- Callbacks -------------------
  
  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  has_many :services, dependent: :destroy
  has_many :messages, through: :services
  
  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }
  
  ##-- Methods ---------------------
  


  
end
