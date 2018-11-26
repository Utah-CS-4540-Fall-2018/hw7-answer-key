# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :searches
  has_many :listings, through: :searches

  #validates :email, :format, regex...
  validates :first_name, presence: true
  validates :last_name, presence: true  

  validates :email, uniqueness: { message: "Another use is already using that email!" }
  validates :first_name, length: { minimum: 3 }
  validates :last_name, length: { minimum: 2 }

  validates :first_name, :last_name, 
    exclusion: { 
      in: ['not', 'nice', 'words'], 
      message: "Tsk, tsk, please refrain from bad language in this attribute" 
    }

  validates :email, 
    format: { 
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,
      message: 'Email address in not well-formed'
    }

  def reviewed_listings
    self.listings.merge(Listing.reviewed)
  end
  
  def not_reviewed_listings
    self.listings.merge(Listing.not_reviewed)
  end

  def alerted_listings
    self.listings.merge(Listing.alerted)
  end

  def not_alerted_listings
    self.listings.merge(Listing.not_alerted)
  end

  def has_new_listings?
    self.not_reviewed_listings.count > 0
  end

end
