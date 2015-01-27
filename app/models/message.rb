# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  service_id    :integer
#  service_token :text
#  content       :text
#  url           :text
#  from_url      :text
#  tags          :text
#  created_at    :datetime
#  updated_at    :datetime
#  has_been_sent :boolean          default(FALSE)
#  from_api      :boolean          default(FALSE)
#  sent_time     :datetime
#  person        :string(255)
#

class Message < ActiveRecord::Base
  ##-- Requirements and Concerns ---

  ##-- Constants--------------------

  ##-- Virtual Attributes ----------

  ##-- Validations -----------------
  # validates :email, presence: true
  # validates :username, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates :service, presence: true

  ##-- Callbacks -------------------
  after_create :send_message

  ##-- Associations ----------------
  # has_many :roles, dependent: :destroy
  # has_many :users, through: :memberships
  belongs_to :service

  ##-- Scopes ----------------------
  # scope :active, -> { where(active: true) }

  ##-- Methods ---------------------
  
  # Return an array of tags separated by ,
  def tags_array
    tags_array = self.tags.to_s.split(',')
  end
  
  # Callbacks after creation
  def send_message
    success = self.service.send_message(self)
    if success
      self.update_columns(has_been_sent: true, sent_time: DateTime.now )
    end
  end
  
  # Class method to create a message from the API
  def self.create_from_api(message_hash, service)
    content = message_hash[:content].to_s
    url = message_hash[:url].to_s
    tags = message_hash[:tags].to_s
    person = message_hash[:person].to_s
    service_id = service.id
    Message.create(:content => content, :url => url, :tags => tags, :service_id => service_id, :from_api => true, :person => person)
  end
  
  

end
