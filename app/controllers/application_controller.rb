class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  private

  def render_errors(resource)
    render json: { errors: resource.errors }, status: 422
  end
end
