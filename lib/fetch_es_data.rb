# having methods to fetch data from Elastic search
class FetchEsData

	# initializing elastic search host and port
	def initialize(search_host, search_port)
		@search_host = search_host
		@search_port = search_port
	end

	def fetch_shortlisted_data_from_es(query, index_name, type_name)
		uri = URI("http://#{@search_host}:#{@search_port}/#{index_name}/#{type_name}/_search")
		req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
		req.body = "#{query.to_json}\n"
		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
			http.request(req)
		end
		if res.code == "200"
			body = JSON.parse(res.body) rescue {}
		else
			body = []
		end
	end
end