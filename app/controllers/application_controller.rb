class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all  { render :nothing => true, :status => 404 }
    end
  end

  rescue_from ActionController::ParameterMissing do
    respond_to do |type|
      type.all  { render json: {error: 'Faltan parámetros'}, :status => 400 }
    end
  end
end
