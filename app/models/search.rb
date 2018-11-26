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

class Search < ApplicationRecord
  belongs_to :user
  has_many :listing_searches
  has_many :listings, through: :listing_searches

  validates :keywords, presence: true
  validates :keywords, uniqueness: { scope: :user_id }

  validates :keywords, 
    exclusion: { 
      in: ['not', 'nice', 'words'], 
      message: "Tsk, tsk, please refrain from bad language in the keywords" 
    }

  #scope :listings_not_reviewed, -> { listings_searches}
end
