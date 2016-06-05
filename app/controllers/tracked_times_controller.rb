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

  def copy
    @time = TrackedTime.today.find(params[:id])
    @dup = @time.copy!
    render json: {error: "No se pudo crear una copia" }, status: 404 unless @dup
  end

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
