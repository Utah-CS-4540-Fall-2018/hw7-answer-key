json.extract! listings_poll, :id, :is_automated, :started_at, :finished_at, :notes, :created_at, :updated_at
json.url listings_poll_url(listings_poll, format: :json)
