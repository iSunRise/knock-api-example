class SpecialtiesController < ApplicationController
  include SpecialtyDocumentation if ENV['SWAGGER'].present?
  before_action :authenticate_account, only: :create

  def index
    specialties = Specialty.limit(50).order('name ASC')
    specialties = specialties.where(name_query) if params[:name].present?
    render json: specialties
  end

  private

  def name_query
    ['LOWER(name) LIKE ?', '%' + params[:name].to_s.downcase + '%']
  end
end
