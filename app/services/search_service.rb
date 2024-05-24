class SearchService
  def self.search(search_params)
    conn = Faraday.new("https://api.nal.usda.gov") do |faraday|
      faraday.headers["X-Api-Key"] =
        Rails.application.credentials.fdc[:api_key]
      faraday.headers["accept"] = "application/json"
      faraday.params["query"] = search_params
      faraday.params["dataType"] = "Branded"
      faraday.params["pageSize"] = 10
    end

    response = conn.get("/fdc/v1/foods/search")

    JSON.parse(response.body, symbolize_names: true)[:foods]
  end
end
