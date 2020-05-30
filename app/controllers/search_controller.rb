class SearchController < ApplicationController
  def create
    redirect_to recipes_path(params: search_params)
  end

  private

  def search_params
    params.permit(:ingredients,
                  :time,
                  :type,
                  diet: [])
  end
end
