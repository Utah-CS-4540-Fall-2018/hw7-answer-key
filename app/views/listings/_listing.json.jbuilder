json.extract! listing, :id, :url, :title, :description, :pricing, :listings_poll_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
