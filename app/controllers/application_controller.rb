class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  private

  def render_errors(resource, errors = nil)
    errors ||= resource.errors
    render json: { errors: errors }, status: 422
  end
end
