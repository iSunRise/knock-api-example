class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  private

  def render_errors(resource, errors = nil)
    errors ||= resource.errors
    errors = errors.map do |key, message|
      [key, key.to_s.humanize + ' ' + message]
    end.to_h
    render json: { errors: errors }, status: 422
  end
end
