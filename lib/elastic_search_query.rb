class ElasticSearchQuery


	#### All Get Query ================================================================

  # returns the structure for ids matching
  def self.get_ids_query_structure
    {
      :ids => {
        :values => []
      }
    }
  end

  # returns constant score filter structure
  def self.get_constant_score_filter_structure filter = {}, boost = 1
    {
      :constant_score => {
        :filter => filter,
        :boost => boost
      }
    }
  end

  # returns constant score query structure
  def self.get_constant_score_query_structure query = {}, boost = 1
    {
      constant_score: {
        filter: {
            bool: {
                must: query
            }
        },
        boost: boost
      }
    }
   end

  # returns exists filter
  def self.get_exists_filter field
    {
      constant_score: {
        filter: {
          exists: {
            field: field
          }
        }
      }
    }
  end

  # With Elasticsearch 6.1 nested filter has been replaced with nested query
  # nested filter structure
  def self.get_nested_filter_structure path, query = {}
    {
      :nested => {
        :path => path,
        :query => query
      }
    }
  end

  # returns nested query structure
  def self.get_nested_query_structure path, query = {}, score_mode=nil
    raise ArgumentError.new("path has to be a string") unless (path.is_a? String)
    subquery = {
      :nested => {
        :path => path,
        :query => query
      }
    }
    if Constants::FUNCTION_SCORE_METHODS.include? score_mode
      subquery[:nested][:score_mode] = score_mode
    end
    return subquery
  end

  # returns structure for match_phrase_prefix
  def self.get_match_phrase_prefix_query field, prefix
      raise ArgumentError.new("field and prefix should be strings") unless (field.is_a? String) && (prefix.is_a? String)
      return {
        :match_phrase_prefix => {
          field => prefix
        }
      }
  end

  # term filter query
  def self.get_term_filter_query(field, value, cache_flag = false)
    {
      term: {
        field => value
      }
    }
  end

  # term boost query
  def self.get_term_boost_query field, value, boost
    {
      :term => {
        field => {
          :value => value,
          :boost => boost
        }
      }
    }
  end

  # returns terms_filter_query
  def self.get_terms_filter_query(field, value)
      raise "Cannot append terms query to #{value} which is not an array" unless value.is_a?(Array)
      {
        terms: {
          field => value
        }
      }
  end

  # returns filtered_structure
  def self.get_filtered_structure
    {
      bool: {
          must: [],
          should: [],
          must_not: [],
          filter: {
              bool: {
                  must: [],
                  should: [],
                  must_not: []
              }
          }
      }
    }
  end

  # returns range query
  def self.get_range_query field, from, to
    q = {
      :range=> {
        field => {}
      }
    }
    q[:range][field][:from] = from if from.present?
    q[:range][field][:to] = to if to.present?
    return q
  end

  # returns nested terms query
  def self.get_nested_terms_query(path, field, value)
    raise "Cannot append terms query to #{value} which is not an array" unless value.is_a?(Array)
    {
      nested: {
        path: path,
        query: {
          terms: {
            field => value
          }
        }
      }
    }
  end

  # returns basic bool structure with should, must and mus_not clause
  def self.get_bool_filter_structure
    {
      bool: {
        must: [],
        should: [],
        must_not: []
      }
    }
  end

  # returns query bool structure
  def self.get_query_bool_structure
    {
      query:{
        bool: {
          filter:{
          }
        }
      }
    }
  end

  
  # used to append sort query so that the result is sorted based on the sort_fields provided
  def self.get_sort_subquery sort_fields=[]
      raise "Cannot append sort query which is not an array" unless sort_fields.is_a?(Array)
      sort = []
      sort_fields.each do |field|
        if field.is_a? Hash
          field.each do |key, order|
            next unless (order=="asc" || order=="desc")
            sort << {key => {"order" => order}}
          end
        elsif (field.is_a? String) || (field.is_a? Symbol)
          sort << field.to_s
        end
      end
      return sort
  end

  # constraucts a top_hits structure
  # this aggregator is intended to be used as a sub aggregator,
  # so that the top matching documents can be aggregated per bucket
  # @param name [String] name of the aggregation
  # @param size [Integer] specifying number of top results to be returned
  # @param sort [Array] specifying the sorting order
  # @param source [Array] specifying the data fields to be present in the result
  def self.get_top_hits_aggregations name, size, sort, source = []
    query = {
      name => {
        "top_hits": {
          "size": size
        }
      }
    }.with_indifferent_access
    query[name]["top_hits"]["sort"] = sort if sort.present?
    if source.present?
      query[name]["top_hits"]["_source"] = {
        "include": source
      }
    end
    query
  end

  # returns a reverse nested structure
  def self.get_reverse_nested_aggs name, aggregations
    {
      name => {
        "reverse_nested": {},
        "aggs": aggregations
      }
    }
  end

  def self.get_terms_aggregation_structure name, field_name, include_array = [], script = "", size = nil
    query = {
      name => {
        terms: {
          field: field_name
        }
      }
    }
    query[name][:terms][:include] = include_array if include_array.present?
    if script.present?
      query[name][:terms].delete(:field)
      query[name][:terms][:script] = script
    end
    if size.present? 
      size = 1  if size == 0 #size 0 is not supported since ES 5
      query[name][:terms][:size] = size
    end
    query
  end

  # returns a generic metrics aggregation by providing the comparator
  # @param name [String] name of the aggregation
  # @param comparator [String] the metric to be used (eg. cardinality, avg)
  # @param field_name [String] field on which aggregation is used
  def self.get_metrics_aggregations_query name, comparator, field_name
    query = {
      name => {
        comparator => {
          field: field_name
        }
      }
    }
  end

  # this helps to contruct a structure where we can use aggregations on the nested objects also.
  # @param name [String] name of the aggregation
  # @param path [String] path to the nested object
  # @param field_name [String] field on which aggregation is used
  # @param aggregation [Hash] specifying the aggregations (eg. Average)
  def self.get_nested_aggregation_query name, path, aggregation
    query = {
      name => {
        nested: {
          path: path
        },
        aggregations: aggregation
      }
    }
  end

  # builds ids query with provided values
  def self.get_ids_filter_query ids
    ids_query_structure = get_ids_query_structure
    ids_query_structure[:ids][:values] = ids
    ids_query_structure
  end


  # constructs a structure that defines a single bucket which matches a specified filter
  # @param name [String] name of the aggregation
  # @param aggregation [Hash] specifying the aggregations (eg. Average)
  # @params filter [Hash] the matching condition (eg. { "term": { "type": "t-shirt" } })
  def self.filtered_aggregation name, aggregation, filter
    {
      :aggs => {
        name.intern => {
          filter: filter,
          aggs: aggregation
        }
      }
    }
  end

  # calculates percentiles based on the field and provided percentile points
  # @param aggregation_name [String] name of the aggregation
  # @param field [String] on which aggregation is to be performed
  # @param percentile_points [Array] percentile points in which we are interested
  def self.percentile_aggregation aggregation_name, field, percentile_points
    {
      aggregation_name.intern => {
        :percentiles => {
          :field => field,
          :percents => percentile_points
        }
      }
    }
  end

  # used for bucketing the response based on the field and range provided
  # sample range [{ "to" : 100.0 },{ "from" : 100.0, "to" : 200.0 },{ "from" : 200.0 }]
  # @param aggregation_name [String] name of the aggregation
  # @param field [String] on which aggregation is to be performed
  # @param ranges [Array] specifying ranges
  def self.range_aggregation aggregation_name, field, ranges
    {
      aggregation_name.intern => {
        :range => {
          :field => field,
          :ranges => ranges
        }
      }
    }
  end

  # constructs an aggregation structure based on field_name provided
  # this dynamically builds buckets on the basis of field_name and provides the aggregations accordingly
  # if field_name = genre and genre has values (rock, jazz, thrash metal), then aggregations will be based on these three genres
  # @param name [String] name of the aggregation
  # @param field_name [String] on which aggregation is to be performed
  # @param aggregation [Array] specifying aggregations
  # @param include_array [Array] specifying conditions on the field_name
  # @param script [Hash], to be executed for aggregation
  def self.get_terms_structure_with_aggregation name, field_name, aggregation, include_array = [], script = ""
    query = get_terms_aggregation_structure name, field_name, include_array, script
    query[name][:aggs] = aggregation
    return query
  end

  def self.function_score query, seed
    {
      function_score: {
        query: query,
        functions: [
          {
            random_score: {
              seed: seed
            }
          }
          ]
      }
    }
  end

  # returns a structure of dis_max query.
  # @param queries [Array], array of queries used for union
  def self.dis_max_query queries=[]
    raise ArgumentError.new("queries is not an Array") unless queries.instance_of? Array
    return {
      dis_max: {
        queries: queries
      }
    }
  end

  # to modify the score of documents that are retrieved by a query
  # @param query [Hash]
  # @param functions [Array] specifying the conditions and scores
  # @param boost_mode [String] specifying boost_mode (replace, multiply)
  def self.script_scoring_query(query, functions, boost_mode="replace")
    return query.except(:query).merge({
      query: {
        function_score: {
          query: query[:query],
          functions: functions,
          boost_mode: boost_mode
        }
      }
    })
  end

  def self.get_script_score_function_structure
    return {
      script_score: {
          script: {
              params: {},
              inline: ''
          }
      }
    }
  end

  # get nested query to search on nested objects
  def self.get_nested_exists_query field_name
    {
      nested: {
        path: field_name,
        query: {
          match_all: {}
        }
      }
    }
  end

  # this appends bools structure containing must, should and must_not in an existing query under the filter context
  # if filter is not present in the existing query, the entire bool structure is assigned,
  # if filter is present, then the bool structure is merged with the existing structure under the filter context
  # finally the filter priovided in the method params is appended in the must clause
  # @param query [Hash] main query
  # @param filter [Hash] assigned in the must clause of the main query
  def self.append_query_filter(query, filter)
    bool_query = get_bool_filter_structure
    if query[:query][:bool][:filter].nil?
      query[:query][:bool][:filter] = bool_query
    else
      bool_query[:bool].each { |key, val|
        query[:query][:bool][:filter][:bool][key] = [] unless query[:query][:bool][:filter][:bool].key? (key)
      }
    end
    query[:query][:bool][:filter][:bool][:must].push(filter)
    query
  end

  # sets the max number of results to be returned by the query
  # @param query [Hash] query to be modified
  # @param size [integer] limit value
  def self.append_size_filter(query, size)
    query[:size] = size
    query
  end

  # from filter sets the offset, from where the data is to be returned
  # @param query [Hash] query to be modified
  # @param from [integer] offset value
  def self.append_from_filter(query, from)
    query[:from] = from
    query
  end

  # merges bool queries into the main_query
  # @param main_query [Hash] query to be modified
  # @param query [Hash] query whose bool params are to be merged in main_query
  def self.merge_bool_query(main_query, query)
    query[:bool].each { |key, val|
      if main_query[:bool].key?(key)
        main_query[:bool][key] = Array.new([main_query[:bool][key]]) << val
        main_query[:bool][key].flatten!
      else
        main_query[:bool][key] = val
      end
    }
    main_query
  end

end