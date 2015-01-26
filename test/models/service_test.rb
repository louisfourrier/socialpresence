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

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
