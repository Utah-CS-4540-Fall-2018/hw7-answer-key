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

class Listing < ApplicationRecord
  has_many :listing_searches
  has_many :searches, through: :listing_searches
  has_many :users, through: :searches  
  belongs_to :listings_poll

  # one way of doing the scopes...
  scope :low_cost,    -> { where(price: 0..99.99) }
  scope :medium_cost, -> { where(price: 100..499.99) }
  scope :high_cost,   -> { where(price: 500..Float::INFINITY) }

  scope :by_ids, ->(list_of_ids) { where(id: list_of_ids) }


  # We don't need this now that we're moving to a 'status' atttribute...
  # scope :reviewed, -> { where.not(reviewed_at: nil) }
  # scope :not_reviewed, -> { where(reviewed_at: nil) }

  # scope :alerted, -> { where.not(alerted_at: nil) }
  # scope :not_alerted, -> { where(alerted_at: nil) }

  scope :newest_first, -> { order(updated_at: :desc)}

  # ...here's the status attribute.  It's an enumerated type.  In Rails,
  # we'll track the different status types as symbols and the line 
  # below defines the possible symbols.  In the database, this attribute
  # is represented by an integer and Rails' ActiveRecord (the ORM) 
  # handles the mapping between the integer field and the 
  # enumerated type attribute.  
  enum status: [:not_yet_seen, :ignore, :watch]

  def mark_as_new
    self.status = :not_yet_seen
    self.save!
  end

  def mark_as_ignore
    self.status = :ignore
    self.save!
  end

  def mark_as_watch
    self.status = :watch
    self.save!
  end

  def mark_as_alerted
    self.alerted_at = Time.now 
    self.save!
  end

  def self.not_reviewed
    self.not_yet_seen
  end

  

  def self.mass_set_status(listings_scope = Listing.all, list_of_ids, status_to_set)
    # verify the status to set is legit
    unless Listing.statuses.has_key?(status_to_set)
      raise ArgumentError, 'No such status to set: ' + status_to_set
    end
    listings_scope.by_ids(list_of_ids).update_all(status: status_to_set)
  end
end
