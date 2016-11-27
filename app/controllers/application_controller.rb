class ApplicationController < ActionController::API
  include Knock::Authenticable

  private

  def render_errors(resource)
    render json: { errors: resource.errors }, status: 422
  end
end
