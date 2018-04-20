class TokenQueryBuilder

	def self.construct_match_filter(analyzer, field_name, query, opts)
	default_options = {fuzziness: 0, prefix_length: 1, max_expansions: 20, operator: "or"}
	opts = default_options.merge(opts)
	field = analyzer.present? ? "#{field_name}.#{analyzer}": "#{field_name}"
	{
	  match: {
	    field => {
	      query: query,
	      operator: opts[:operator],
	      fuzziness: opts[:fuzziness],
	      prefix_length: opts[:prefix_length]
	    }
	  }
	}
	end

	def self.wrap_constant_score_query(filters: [], boost: 0)
	 	{
	    constant_score: {
	      boost: boost,
	        filter: {
	          bool: {
	            should: filters
          	}
        	}
      }
    }
	end

	def self.cs_with_multiple_filter(analyzer, query, opts, keys = [], boost: 0)
	  filters = []
	  (keys.compact).each do |key|
	    filter = construct_match_filter(analyzer, key, query, opts)
	    filters.push(filter)
	  end
	  wrap_constant_score_query(filters: filters, boost: boost)
	end

	def self.cs_with_single_filter(query, key = "")
	  get_term_filter_query key, query, true
	end

	def self.keyword_without_edit_distance(query, key, alias_key, boost = 1.5)
	  cs_with_multiple_filter("name_edgegram_keyword", query, {operator: "and"}, [key, alias_key], boost: boost)
	end

	def self.edgegram_without_edit_distance(query, key, alias_key, boost = 1.5)
	  cs_with_multiple_filter("name_edgegram", query, {operator: "and"}, [key, alias_key], boost: boost)
	end

	def self.edgegram(query, key, alias_key)
	  cs_with_multiple_filter("name_edgegram", query, {operator: "and", fuzziness: 1, prefix_length: 2}, [key, alias_key], boost: 1)
	end

	def self.keyword(query, key, alias_key)
	  cs_with_multiple_filter("name_edgegram_keyword", query, {operator: "and", fuzziness: 1, prefix_length: 2}, [key, alias_key], boost: 1)
	end

	def self.simple_name(query, key, alias_key)
	  cs_with_multiple_filter("", query, {operator: "and", fuzziness: 1, prefix_length: 1}, [key, alias_key], boost: 2)
	end

	def self.simple_name_without_edit_distance(query, key, alias_key)
	  cs_with_multiple_filter("", query, {operator: "and"}, [key, alias_key], boost: 3)
	end

	def self.separated_name(query, key, alias_key)
	  cs_with_multiple_filter("separated_names", query, {operator: "and", fuzziness: 1, prefix_length:1}, [key, alias_key], boost: 2)
	end

	def self.first_name(query, key, alias_key)
	  cs_with_multiple_filter("first_name", query, {operator: "and", fuzziness: 1}, [key, alias_key], boost: 0.6)
	end

	def self.city_biasing(query)
	  cs_with_multiple_filter("", query, {}, [@city_biasing_field], boost: 0.6)
	end

	def self.polygon_uuid_filter(query, polygon_uuid_filter_key)
	  cs_with_single_filter(query, polygon_uuid_filter_key)
	end

	def self.exclude_uuids_filter(query, exclude_uuid_key)
	  cs_with_multiple_filter("", query, {}, [exclude_uuid_key], boost: 0.0)
	end

end
