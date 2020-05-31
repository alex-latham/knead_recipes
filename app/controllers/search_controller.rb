class SearchController < ApplicationController
  def create
    redirect_to recipes_path(params: search_params)
  end

  private

  def search_params
    params[:time] = params[:time].to_i if params[:time].present?
    params[:diet] = params[:diet].join(',') if params[:diet].present?
    params.permit(:ingredients, :time, :type, :diet)
  end
end
