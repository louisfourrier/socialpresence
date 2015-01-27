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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
