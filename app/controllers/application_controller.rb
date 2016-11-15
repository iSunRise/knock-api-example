class ApplicationController < ActionController::API
  include Knock::Authenticable

  private

  def render_errors(resource)
    render json: resource, status: 422,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
