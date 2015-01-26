# == Schema Information
#
# Table name: services
#
#  id                  :integer          not null, primary key
#  provider            :string(255)
#  uid                 :string(255)
#  name                :string(255)
#  total_field         :text
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#  access_token        :text
#  access_token_secret :text
#  service_token       :text
#  tags                :text
#
class Service < ActiveRecord::Base
  ##-- Requirements and Concerns ---
  require 'securerandom'

  ##-- Constants--------------------

  ##-- Virtual Attributes ----------
  serialize :total_field

  ##-- Validations -----------------
  validates :provider, presence: true
  validates :name, presence: true
  validates :uid, presence: true
  validates :uid, uniqueness: true
  validates :service_token, uniqueness: true

  # validates :username, uniqueness: { case_sensitive: false }

  ##-- Callbacks -------------------
  after_save :create_tokens
  before_validation :create_service_token, :on => :create

  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  belongs_to :user
  has_many :messages, dependent: :destroy

  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }

  ##-- Methods ---------------------

  def full_name
    return self.provider.to_s + " (" + self.name.to_s + ")"
  end

  def self.from_omniauth(auth, user)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth, user)
  end

  def self.create_from_omniauth(auth, user)
    create! do |service|
      service.provider = auth["provider"]
      service.uid = auth["uid"]
      service.name = auth["info"]["nickname"]
      service.total_field = auth.to_json
      service.user_id = user.id
    end
  end

  # Send Message
  def send_message(message)
    if self.provider == "twitter"
        content = message.content
        url = message.url
        tags = message.tags_array
        sender = TwitterSender.new(self.access_token, self.access_token_secret)
        sender.send_tweet(content, url, tags)
    end
  end

  # Test message
  def send_test
    if self.provider == "twitter"
      sender = TwitterSender.new(self.access_token, self.access_token_secret)
    sender.test
    end
  end

  # Return the global hash returned by the provider
  def properties
    JSON.parse(self.total_field)
  end

  # Refresh the service token
  def refresh_service_token
    token = SecureRandom.hex
    while(Service.find_by(service_token: token)) do
      token = SecureRandom.hex
    end
    self.update(:service_token => token)
  end

  # Callback to create service token
  def create_service_token
    token = SecureRandom.hex
    while(Service.find_by(service_token: token)) do
      token = SecureRandom.hex
    end
    self.service_token = token
  end

  # Callbacks to save the Access tokens
  def create_tokens
    if self.provider == "twitter"
      access_token = self.properties['credentials']['token']
      access_token_secret = self.properties['credentials']['secret']
      self.update_columns(access_token: access_token,access_token_secret: access_token_secret )
    end
  end

end
