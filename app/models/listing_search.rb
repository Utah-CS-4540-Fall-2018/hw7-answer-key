# == Schema Information
#
# Table name: listing_searches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer
#  search_id  :integer
#
# Indexes
#
#  index_listing_searches_on_listing_id  (listing_id)
#  index_listing_searches_on_search_id   (search_id)
#

class ListingSearch < ApplicationRecord
  belongs_to :search
  belongs_to :listing
end
