module HomeHelper

  def listings_not_reviewed_count
    current_user.not_reviewed_listings.count
  end

end
