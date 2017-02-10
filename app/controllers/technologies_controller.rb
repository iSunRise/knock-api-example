class TechnologiesController < ApplicationController
  before_action :authenticate_account, only: :create

  def index
    technologies = Technology.limit(20).order('name ASC')
    technologies = technologies.where(name_query) if params[:name].present?
    render json: technologies
  end

  def create
    technology = Technology.new(technology_params)
    if technology.save
      render json: technology
    else
      render_errors(technology)
    end
  end

  private

  def name_query
    ['LOWER(name) LIKE ?', '%' + params[:name].to_s.downcase + '%']
  end

  def technology_params
    params.require(:technology).permit(:name)
  end
end
