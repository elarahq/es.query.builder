class ElasticSearchQuery

	# # geo queries
 #  def append_geo_range_filter_query(field, min_value, max_value, latitude, longitude)
 #    bool_filter_structure = get_bool_filter_structure        
 #    if min_value.blank? && max_value.present? && max_value.to_f > 0
 #      bool_filter_structure[:bool][:must].push(get_geo_query field, latitude, longitude, (max_value.to_f/1000.0).to_s + "km")
 #      build_filter_hash(field, bool_filter_structure)
 #    elsif min_value.present? && max_value.blank? && min_value.to_f > 0
 #      bool_filter_structure[:bool][:must_not].push(get_geo_query field, latitude, longitude, (min_value.to_f/1000.0).to_s + "km")
 #      build_filter_hash(field, bool_filter_structure)
 #    elsif max_value.present? && min_value.present?
 #      bool_filter_structure[:bool][:must_not].push(get_geo_query field, latitude, longitude, (min_value.to_f/1000.0).to_s + "km") if min_value.to_f > 0
 #      bool_filter_structure[:bool][:must].push(get_geo_query field, latitude, longitude, (max_value.to_f/1000.0).to_s + "km") if max_value.to_f > 0
 #      build_filter_hash(field, bool_filter_structure)
 #    end
 #    return self
 #  end

 #  def get_geo_query key, latitude, longitude, radius, cache_flag = false
 #    {geo_distance: {key => {lat: latitude.to_f, lon: longitude.to_f}, distance: radius, distance_type: :arc}}
 #  end



	#### All Get Query ================================================================

  def get_ids_query_structure
    {
      :ids => {
        :values => []
      }
    }
  end

  def get_constant_score_filter_structure filter = {}, boost = 1
    {
      :constant_score => {
        :filter => filter,
        :boost => boost
      }
    }
  end

  def get_constant_score_query_structure query = {}, boost = 1
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

  def get_exists_filter field
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

  #With Elasticsearch 6.1 nested filter has been replaced with nested query
  def get_nested_filter_structure
    {
      :nested => {
        :path => "",
        :query => {}
      }
    }
  end

  def get_nested_query_structure
    {
      :nested => {
        :path => "",
        :query => {}
      }
    }
  end

  def get_term_filter_query(field, value, cache_flag = false)
    {
      term: {
        field => value
      }
    }
  end

  def get_term_boost_query field, value, boost
    {
      :term => {
        field => {
          :value => value,
          :boost => boost
        }
      }
    }
  end

  def get_terms_filter_query(field, value)
      raise "Cannot append terms query to #{value} which is not an array" unless value.is_a?(Array)
      {
        terms: {
          field => value
        }
      }
  end

  def get_filtered_structure
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

  def get_range_query field, from, to
    q = {
      :range=> {
        field => {}
      }
    }
    q[:range][field][:from] = from if from.present?
    q[:range][field][:to] = to if to.present?
    return q
  end

  def get_nested_terms_filter_query(path, field, value, cache_flag = false)
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

  def get_nested_terms_query(path, field, value)
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

  def get_bool_filter_structure
    {
      bool: {
        must: [],
        should: [],
        must_not: []
      }
    }
  end

  def get_query_bool_structure
    {
      query:{
        bool: {
          filter:{
          }
        }
      }
    }
  end

  def get_sort_subquery sort_fields=[]
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

  def get_top_hits_aggregations name, size, sort, source = []
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

  def get_reverse_nested_aggs name, aggregations
    {
      name => {
        "reverse_nested": {},
        "aggs": aggregations
      }
    }
  end

  def get_terms_aggregation_structure name, field_name, include_array = [], script = "", size = nil
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

  def get_metrics_aggregations_query name, comparator, field_name
    query = {
      name => {
        comparator => {
          field: field_name
        }
      }
    }
  end

  def get_nested_aggregation_query name, path, aggregation
    query = {
      name => {
        nested: {
          path: path
        },
        aggregations: aggregation
      }
    }
  end

  def get_bounding_box_filter_query(key, ne_lat_lng, sw_lat_lng, cache_flag = false)
    {geo_bounding_box: {key => {top_right: {lat: ne_lat_lng[:latitude].to_f,
                                            lon: ne_lat_lng[:longitude].to_f},
                                bottom_left: {lat: sw_lat_lng[:latitude].to_f,
                                              lon: sw_lat_lng[:longitude].to_f }},
                                type: "indexed" }}
  end

  def get_geo_polygon_filter_query(key, array_lat_longs, cache_flag = false)
    {geo_polygon: {key => {points: array_lat_longs}}}
  end

  def get_multi_geo_polygon_filter_query(key, multipolygon, cache_flag = false)
    should_query = Array.new
    multipolygon.each { |a| should_query.push({geo_polygon: {key => {points: a.first}}}) }
    { bool: { should: should_query } }
  end

  def get_geo_distance_filter_query key, latitude, longitude, radius, cache_flag = false
    {geo_distance: {key => {lat: latitude.to_f, lon: longitude.to_f}, distance: radius, distance_type: :arc}}
  end

  def get_geo_distance_query_with_location_string key, location, radius, cache_flag = false
    {
      geo_distance:
      {
        key => location, 
        distance: radius, 
        distance_type: :arc
      }
    }
  end

 #  def must_entity_filter(polygon_filter, establishment_filter, developer_filter, building_filter)
 #    bool_filter_structure = get_bool_filter_structure
 #    bool_filter_structure[:bool][:must].push(polygon_filter)
 #    bool_filter_structure[:bool][:must].push(establishment_filter)
 #    bool_filter_structure[:bool][:must].push(developer_filter)
 #    bool_filter_structure[:bool][:must].push(building_filter)
 #    bool_filter_structure[:bool][:must].compact!
 #    bool_filter_structure
 #  end

 #  def should_entity_filter(polygon_filter, establishment_filter, developer_filter, building_filter)
 #    bool_filter_structure = get_bool_filter_structure
 #    bool_filter_structure[:bool][:should].push(polygon_filter)
 #    bool_filter_structure[:bool][:should].push(establishment_filter)
 #    bool_filter_structure[:bool][:should].push(developer_filter)
 #    bool_filter_structure[:bool][:should].push(building_filter)
 #    bool_filter_structure[:bool][:should].compact!
 #    bool_filter_structure
	# end

	def get_ids_filter_query ids
    ids_query_structure = get_ids_query_structure
    ids_query_structure[:ids][:values] = ids
    ids_query_structure
  end


  def filtered_aggregation name, aggregation, filter
    {
      :aggs => {
        name.intern => {
          filter: filter,
          aggs: aggregation
        }
      }
    }
  end

  def percentile_aggregation aggregation_name, field, percentile_points
    {
      aggregation_name.intern => {
        :percentiles => {
          :field => field,
          :percents => percentile_points
        }
      }
    }
  end

  def range_aggregation aggregation_name, field, ranges
    {
      aggregation_name.intern => {
        :range => {
          :field => field,
          :ranges => ranges
        }
      }
    }
  end

  def get_nested_terms_aggregation_structure name, field_name, aggregation, include_array = [], script = ""
    query = get_terms_aggregation_structure name, field_name, include_array, script
    query[name][:aggs] = aggregation
    return query
  end

  def function_score query, seed
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

  def dis_max_query queries=[]
    raise ArgumentError.new("queries is not an Array") unless queries.instance_of? Array
    return {
      dis_max: {
        queries: queries
      }
    }
  end

  def script_scoring_query(query, functions, boost_mode="replace")
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

  def get_script_score_function_structure
    return {
      script_score: {
          script: {
              params: {},
              inline: ''
          }
      }
    }
  end

  def get_nested_exists_query field_name
    {
      nested: {
        path: field_name,
        query: {
          match_all: {}
        }
      }
    }
  end

  def append_query_filter(query, filter)
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

  def append_size_filter(query, size)
    query[:size] = size
    query
  end

  def merge_bool_query(main_query, query)
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