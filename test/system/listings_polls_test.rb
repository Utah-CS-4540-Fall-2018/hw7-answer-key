require "application_system_test_case"

class ListingsPollsTest < ApplicationSystemTestCase
  setup do
    @listings_poll = listings_polls(:one)
  end

  test "visiting the index" do
    visit listings_polls_url
    assert_selector "h1", text: "Listings Polls"
  end

  test "creating a Listings poll" do
    visit listings_polls_url
    click_on "New Listings Poll"

    fill_in "Finished At", with: @listings_poll.finished_at
    fill_in "Is Automated", with: @listings_poll.is_automated
    fill_in "Notes", with: @listings_poll.notes
    fill_in "Started At", with: @listings_poll.started_at
    click_on "Create Listings poll"

    assert_text "Listings poll was successfully created"
    click_on "Back"
  end

  test "updating a Listings poll" do
    visit listings_polls_url
    click_on "Edit", match: :first

    fill_in "Finished At", with: @listings_poll.finished_at
    fill_in "Is Automated", with: @listings_poll.is_automated
    fill_in "Notes", with: @listings_poll.notes
    fill_in "Started At", with: @listings_poll.started_at
    click_on "Update Listings poll"

    assert_text "Listings poll was successfully updated"
    click_on "Back"
  end

  test "destroying a Listings poll" do
    visit listings_polls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Listings poll was successfully destroyed"
  end
end
