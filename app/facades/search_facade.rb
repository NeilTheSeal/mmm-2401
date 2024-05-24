class SearchFacade
  attr_reader :results, :search_params, :count

  def initialize(search_params)
    @search_params = search_params
    @count = 0
    @results = search
  end

  def foods
    @results.map do |result|
      Food.new(result)
    end
  end

  private

  def search
    search_results = SearchService.search(@search_params)
    @count = search_results[:totalHits]
    search_results[:foods]
  end
end
