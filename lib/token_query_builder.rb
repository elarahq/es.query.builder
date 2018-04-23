require 'elastic_search_query'
class TokenQueryBuilder

  # constructs match filter based on the field_name and analyzer provided
  # @param analyzer [String] Type of analyzer to be used
  # @param field_name [String] field to be searched
  # @param query [String] input data
  # @param opts [Hash] options to be provided for search (eg. {fuzziness: 0, prefix_length: 1, max_expansions: 20, operator: "and"})
  # @return [Hash] 
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

  # wraps the query in the constant_score structure
  # @param filters [Array] filters to be included
  # @param  boost [Float] to influence the relevance score
  # @return [Hash] 
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

  # constructs match filter based on keys array
  # @param analyzer [String] Type of analyzer to be used
  # @param  query [String] input data
  # @param  opts [Hash] options to be provided for search (eg. {fuzziness: 0, prefix_length: 1, max_expansions: 20, operator: "and"})
  # @param  keys [Array] fields to be queried
  # @param  boost [Float] to influence the relevance score
  # @return [Hash] 
  def self.cs_with_multiple_filter(analyzer, query, opts, keys = [], boost: 0)
    filters = []
    (keys.compact).each do |key|
      filter = construct_match_filter(analyzer, key, query, opts)
      filters.push(filter)
    end
    wrap_constant_score_query(filters: filters, boost: boost)
  end

  # constructs simgle term query
  def self.cs_with_single_filter(query, key = "")
    ElasticSearchQuery.get_term_filter_query key, query, true
  end

  # constructs a constant_score wrapped match query based on the analyzer provided
  # @param analyzer [String] Type of analyzer to be used (Analyzer provided here must be defined in the index definition first)
  # @param query [String] input data
  # @param key [String] field to be searched
  # @param alias_key [String] alias of the field to be searched
  # @param boost [Float] to influence relevance score
  # @param options [Hash] options to be provided for search (eg. {fuzziness: 0, prefix_length: 1, max_expansions: 20, operator: "and"})
  # @return [Hash] 
  def self.constant_score_match_query(analyzer, query, key, alias_key = nil, boost = 1, options = {})
    cs_with_multiple_filter(analyzer, query, options, [key, alias_key], boost: boost)
  end

end
