# == Schema Information
#
# Table name: listings_polls
#
#  id           :integer          not null, primary key
#  finished_at  :datetime
#  is_automated :boolean
#  notes        :text
#  started_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ListingsPollTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
