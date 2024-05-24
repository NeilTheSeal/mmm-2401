class SearchController < ApplicationController
  def index
    @facade = SearchFacade.new(params[:q])
  end
end
