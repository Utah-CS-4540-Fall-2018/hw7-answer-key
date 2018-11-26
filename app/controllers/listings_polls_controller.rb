class ListingsPollsController < ApplicationController
  before_action :set_listings_poll, only: [:show, :edit, :update, :destroy]

  # GET /listings_polls
  # GET /listings_polls.json
  def index
    @listings_polls = ListingsPoll.all
  end

  # GET /listings_polls/1
  # GET /listings_polls/1.json
  def show
  end

  # GET /listings_polls/new
  def new
    @listings_poll = ListingsPoll.new
  end

  # GET /listings_polls/1/edit
  def edit
  end

  # POST /listings_polls
  # POST /listings_polls.json
  def create
    @listings_poll = ListingsPoll.new(listings_poll_params)

    respond_to do |format|
      if @listings_poll.save
        format.html { redirect_to @listings_poll, notice: 'Listings poll was successfully created.' }
        format.json { render :show, status: :created, location: @listings_poll }
      else
        format.html { render :new }
        format.json { render json: @listings_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings_polls/1
  # PATCH/PUT /listings_polls/1.json
  def update
    respond_to do |format|
      if @listings_poll.update(listings_poll_params)
        format.html { redirect_to @listings_poll, notice: 'Listings poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @listings_poll }
      else
        format.html { render :edit }
        format.json { render json: @listings_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings_polls/1
  # DELETE /listings_polls/1.json
  def destroy
    @listings_poll.destroy
    respond_to do |format|
      format.html { redirect_to listings_polls_url, notice: 'Listings poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listings_poll
      @listings_poll = ListingsPoll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listings_poll_params
      params.require(:listings_poll).permit(:is_automated, :started_at, :finished_at, :notes)
    end
end
