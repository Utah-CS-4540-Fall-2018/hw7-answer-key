require 'test_helper'

class ListingsPollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listings_poll = listings_polls(:one)
  end

  test "should get index" do
    get listings_polls_url
    assert_response :success
  end

  test "should get new" do
    get new_listings_poll_url
    assert_response :success
  end

  test "should create listings_poll" do
    assert_difference('ListingsPoll.count') do
      post listings_polls_url, params: { listings_poll: { finished_at: @listings_poll.finished_at, is_automated: @listings_poll.is_automated, notes: @listings_poll.notes, started_at: @listings_poll.started_at } }
    end

    assert_redirected_to listings_poll_url(ListingsPoll.last)
  end

  test "should show listings_poll" do
    get listings_poll_url(@listings_poll)
    assert_response :success
  end

  test "should get edit" do
    get edit_listings_poll_url(@listings_poll)
    assert_response :success
  end

  test "should update listings_poll" do
    patch listings_poll_url(@listings_poll), params: { listings_poll: { finished_at: @listings_poll.finished_at, is_automated: @listings_poll.is_automated, notes: @listings_poll.notes, started_at: @listings_poll.started_at } }
    assert_redirected_to listings_poll_url(@listings_poll)
  end

  test "should destroy listings_poll" do
    assert_difference('ListingsPoll.count', -1) do
      delete listings_poll_url(@listings_poll)
    end

    assert_redirected_to listings_polls_url
  end
end
