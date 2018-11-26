# == Schema Information
#
# Table name: searches
#
#  id                    :integer          not null, primary key
#  keyword_must_have     :string
#  keyword_must_not_have :string
#  keywords              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#
# Indexes
#
#  index_searches_on_user_id  (user_id)
#

require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
