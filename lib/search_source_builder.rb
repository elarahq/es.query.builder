# A search source builder allowing to easily build search source.
class SearchSourceBuilder
  include AttributesReader

  def initialize
    @query = nil
    @aggregations = []
    @sort = []
    @source = []
    @size = nil
    @explain = nil
    @from = nil
    @min_score = nil
    @terminate_after = nil
    @timeout = nil
    @version = nil
    @script = nil
  end

  def body
    body = {}
    body[:query] = @query.query
    body[:aggregations] = @aggregations.map{|agg| agg.query}.reduce({}, :merge) if @aggregations.present?
    body[:sort] = @sort.map{|sort_object| sort_object.query} if @sort.present?
    body[:_source] = @source
    body[:size] = @size
    body[:explain] = @explain
    body[:from] = @from
    body[:min_score] = @min_score
    body[:terminate_after] = @terminate_after
    body[:timeout] = @timeout
    body[:version] = @version
    body[:script] = @script.settings if @script.present?
    return body.compact
  end

# returns query
  def query_expr
    return @query
  end
# sets query
  def query query
    @query = query
    return self
  end

# returns aggregation
  def aggregations_expr
    return @aggregations
  end
# sets aggregation
  def aggregations agg_builder
    if agg_builder.is_a?(Array)
      @aggregations += agg_builder
    else
      @aggregations.append(agg_builder)
    end
    return self
  end

# returns sort
  def sort_expr
    return @sort
  end
# appends sort
  def sort sort, reset: false
    @sort = [] if reset
    sort.is_a?(Array) ? @sort+= sort : @sort.append(sort)
    return self
  end

# returns source_fields
  def source_expr
    return @source
  end
# sets source_fields
  def source source_field, reset: false
    @source = [] if reset
    source_field.is_a?(Array) ? @source+= source_field : @source.append(source_field)
    return self
  end

# returns size
  def size_expr
    return @size
  end
# sets size
  def size size
    @size = size
    return self
  end

# returns explain
  def explain_expr
    return @explain
  end
# sets explain
  def explain explain
    @explain = explain
    return self
  end

# returns from
  def from_expr
    return @from
  end
# sets from
  def from from
    @from = from
    return self
  end

# returns min_score
  def min_score_expr
    return @min_score
  end
# sets min_score
  def min_score min_score
    @min_score = min_score
    return self
  end

# returns terminate_after
  def terminate_after_expr
    return @terminate_after
  end
# sets terminate_after
  def terminate_after terminate_after
    @terminate_after = terminate_after
    return self
  end

# returns timeout
  def timeout_expr
    return @timeout
  end
# sets timeout
  def timeout timeout
    @timeout = timeout
    return self
  end

# returns version
  def version_expr
    return @version
  end
# sets version
  def version version
    @version = version
    return self
  end

# sets script
  def script script
    @script = script
    return self
  end

# returns script
  def script_expr
    return @script
  end

end