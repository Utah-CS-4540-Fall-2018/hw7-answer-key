class HomeController < ApplicationController
  skip_before_action :must_be_logged_in, only: [:external]

  def index
  end

  def external
  end
end
