class TrackedTimesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
     @times = TrackedTime.today
  end

  def current
    @time = TrackedTime.current
    render json: nil unless @time
  end

  def stop
    @time = TrackedTime.current
    @time.stop! if @time
  end

  def create
    @time = TrackedTime.new(time_params)
    if @time.save
    else
      render json: {error: "Already tracking something" }, status: 401
    end
  end

  # def update
  #   recipe = Recipe.find(params[:id])
  #   recipe.update_attributes(params.require(:recipe).permit(:name,:instructions))
  #   head :no_content
  # end
  #
  def destroy
    time = TrackedTime.find(params[:id])
    time.destroy
    head :no_content
  end

  private
    def time_params
      params.require(:tracked_time).permit(:name)
    end
end
