class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # Filtering of Listings
  #
  # The filtering of listings is dictated by the value of :listings_filter
  # stored in the session object.  This value can be:
  #   nil - meaning apply no filtering, aka "All" the records
  #   one of the Listing.statuses enumerated values (e.g. :not_yet_seen, :watch)
  # The tricky part here is that an empty value indicates "All" so there is
  # some extra logic to identify that case.
  # Filtering is applied by the set_filtered_listings method.
  #
  # Setting the Filtering via parameter to the index method:
  #
  # The index method will look for params[:show_filter] as a signal that the 
  # user wants filter the list of listings (@listings).  This value can be:
  #   nil - meaning let the current filtering state stay as it is
  #   :all - set the current filtering state to nil (i.e. show all)
  #   one of the Listing.statuses enumerated values (e.g. :not_yet_seen, :watch)


  # GET /listings
  # GET /listings.json
  def index
    # When calling this function, we'll watch for a parameter called
    # show_filter whose value can set the filtering on the listings.
    # If no such parameter is passed, we'll revert to the filter set
    # on the session object (default is all).  If the parameter is 'all'
    # then we'll clear the session[:listings_filter] value.
    if params[:show_filter].blank?
      session[:listings_filter] ||= :all
    elsif params[:show_filter] == 'all'
      session[:listings_filter] = nil
    else
      session[:listings_filter] = params[:show_filter]
    end
    # listings filter state now set...

    # collect the filtered listings in @listings
    set_filtered_listings
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/1/edit
  def edit
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mass_edit
    ids_to_update = params[:id_list].split(',')
    status_to_set = params[:status_to_set].downcase
    Listing.mass_set_status(current_user.listings, ids_to_update, status_to_set)
    set_filtered_listings
    respond_to do |format|
      format.js 
      format.json { render json: @listings, status: :ok }
    end
  end

  def set_filter
    # ensure the show_filter param is a valid one
    if Listing.statuses.keys.any?{ |s| s == params[:show_filter]}
      session[:listings_filter] = params[:show_filter]
      set_filtered_listings
    elsif params[:show_filter] == 'all'
      session[:listings_filter] = nil
      set_filtered_listings
    else
      # parameter is either 'all' or a bad filter value
      raise ArgumentError, "Bad filter requested."
    end
    respond_to do |format|
      format.js
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = current_user.listings.find(params[:id])
    end

    # filters listings by status using the value stored in the session object
    def set_filtered_listings
      if session[:listings_filter].present?
        @listings = current_user.listings.send(session[:listings_filter]).newest_first.includes(:listings_poll)
      else
        @listings = current_user.listings.newest_first.includes(:listings_poll)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:url, :title, :description, :pricing, :listings_poll_id)
    end
end
