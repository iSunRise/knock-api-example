class TechnologiesController < ApplicationController
  include TechnologyDocumentation if ENV['SWAGGER'].present?
  before_action :authenticate_account, only: :create

  def index
    technologies = Technology.limit(20).order('name ASC')
    technologies = technologies.where(name_query) if params[:name].present?
    render json: technologies
  end

  private

  def name_query
    ['LOWER(name) LIKE ?', '%' + params[:name].to_s.downcase + '%']
  end
end
