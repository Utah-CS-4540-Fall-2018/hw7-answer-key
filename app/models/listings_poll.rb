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

class ListingsPoll < ApplicationRecord
  has_many :listings

  RESULTS_PER_PAGE = 24

  def self.run
    new_poll = self.create(started_at: Time.now)
    Search.all.each do |search|
      new_poll.get_listings_for(search)
    end

    new_poll.finished_at = Time.now
    new_poll.save
  end

  def get_listings_for(a_search)
    @search = a_search

    run_search
    collect_listings
  end

  def run_search
    params = {
      keyword: @search.keywords,
      city: '',
      miles: 25,
      sort: 0,
      priceFrom: '',
      priceTo: '',
      state: '',
      zip: '',
      perPage: RESULTS_PER_PAGE
    }

    # a valid GET request url from the browser
    # example url...
    # https://classifieds.ksl.com/search/?keyword=anvil&zip=&miles=25&priceFrom=&priceTo=&marketType[]=Sale&city=&state=&sort=0
    query_params = URI::QueryParams.dump(params)
    full_url = 'https://classifieds.ksl.com/search/?' + query_params
    log("About to GET: #{full_url}")

    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @results_page = Selenium::WebDriver.for(:chrome, options: options)
    @results_page.get(full_url)
  end

  def collect_listings
    listings = @results_page.find_elements(:css, '.listing-item')
    log("Found #{listings.count} listings.")
    
    listings.each do |l|
      title       = l.find_element(class: 'item-info-title-link').attribute('innerHTML')
      description = l.find_element(class: 'item-description').attribute('innerHTML')
      pricing     = l.find_element(class: 'item-info-price').attribute('innerHTML')
      url         = l.find_element(class: 'listing-item-link').attribute('href')

      # description still has some html and other tags in it
      description.gsub!(/<!-- react-text: \d+ -->/, '')
      description.gsub!(/<!-- \/react-text -->/, '')
      description.gsub!(/<div .+\/div>/, '')

      # convert the currency string to a float if possible
      if /^\$(\d{1,3},?)+\.\d\d$/.match(pricing)
        price = pricing.scan(/[.0-9]/).join.to_f
      else
        price = ''
      end

      @search.listings << self.listings.create(
        title: title,
        description: description,
        pricing: pricing,
        price: price,
        url: url,
        listings_poll_id: self.id
      )
      log("Raw listing: #{l}")
    end
  end


  def log(msg)
    self.update_attribute(:notes,  "#{notes}\n#{msg}")
  end

end
