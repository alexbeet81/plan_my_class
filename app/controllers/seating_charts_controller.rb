class SeatingChartsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_seating_chart, only: [:edit, :update, :destroy]

  def new
    @seating_chart = SeatingChart.new
  end

  def create
    @seating_chart = SeatingChart.new(seating_chart_params)

    if @seating_chart.save
      # TODO: What happens here? display the new seating chart?
    else
      # TODO: Display errors using Turbo frames.
      render :new
    end
  end

  def edit
  end

  def update
    if @seating_chart.update(seating_chart_params)
      # TODO: What happens here? Disaply the edited seating chart?
    else
      # TODO: Dispaly error using Turbo frames
      render :edit
    end
  end

  def destroy
    if @seating_chart.destroy
      # TODO: flash message destroy successful
    else
      # TODO: flash message destroy failed
    end
  end

  private

  def set_seating_chart
    @seating_chart = SeatingChart.find(params[:id])
  end

  def seating_chart_params
    params.require(:seating_chart).permit(:title, :rows, :columns, :classroom_id)
  end
end
