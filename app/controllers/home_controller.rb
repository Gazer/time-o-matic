class HomeController < ActionController::Base
  # Here I want to render the index.html with layout to get the
  # base HTML of the Angular App that include CSS & JS.
  include ActionView::Layouts

  layout 'application'

  def index
  end
end
