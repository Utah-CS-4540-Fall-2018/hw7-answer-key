# == Schema Information
#
# Table name: listings
#
#  id                    :integer          not null, primary key
#  alerted_at            :datetime
#  description           :text
#  last_time_on_the_moon :datetime
#  price                 :float
#  pricing               :string
#  reviewed_at           :datetime
#  status                :integer
#  title                 :string
#  url                   :string
#  walks_like_a_duck     :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  listings_poll_id      :integer
#
# Indexes
#
#  index_listings_on_listings_poll_id  (listings_poll_id)
#

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
