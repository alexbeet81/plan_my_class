class SeatingChartsController < ApplicationController
  def index
    @seating_charts = SeatingChart.all
  end
end
