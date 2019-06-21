class BoolQueryBuilder < QueryBuilder
  
  ADJUST_PURE_NEGATIVE_DEFAULT = true
  NAME = "bool"

  # attr_reader :should_queries, :must_queries, :mustnot_queries, :filter_queries, :minimum_should_match

  def initialize
    @should_queries = []
    @must_queries = []
    @mustnot_queries = []
    @filter_queries = []
    @minimum_should_match = nil
  end

  def query
    query = {}
    bool_query = self.common_query
    bool_query[:should] = @should_queries.map{|query_ob| query_ob.query} if @should_queries.present?
    bool_query[:must] = @must_queries.map{|query_ob| query_ob.query} if @must_queries.present?
    bool_query[:must_not] = @mustnot_queries.map{|query_ob| query_ob.query} if @mustnot_queries.present?
    bool_query[:filter] = @filter_queries.map{|query_ob| query_ob.query} if @filter_queries.present?
    bool_query[:minimum_should_match] = @minimum_should_match if @minimum_should_match.present?
    bool_query[:boost] = @boost if @boost.present?
    query[name.intern] = bool_query
    return query
  end

########## FILTER QUERIES ##########
=begin
  Queries that must appear in the matching documents but don't contribute to scoring.
=end
=begin 
  Gets the filter queries
=end
  def filter_expr
    return self.filter_queries
  end
=begin
  Adds a filter query
=end
  def filter query_builder
    raise "Query in Filter clause cannot be nil" if query_builder.nil?
    @filter_queries.append(query_builder)
    return self
  end


########## SHOULD QUERIES ##########
=begin
  Queries that may appear in the matching documents and will contribute to scoring.
=end
=begin
  Gets the should queries
=end
  def should_expr
    return self.should_queries
  end
=begin
  Adds a should query
=end
  def should query_builder
    raise "Query in Should clause cannot be nil" if query_builder.nil?
    @should_queries.append(query_builder)
    return self
  end


########## MUST QUERIES ##########
=begin
  Queries that must appear in the matching documents and will contribute to scoring.
=end
=begin
  Gets the must queries
=end
  def must_expr
    return self.must_queries
  end
=begin
  Adds a must query
=end
  def must query_builder
    raise "Query in Must clause cannot be nil" if query_builder.nil?
    @must_queries.append(query_builder)
    return self
  end


########## MUSTNOT QUERIES ##########
=begin
  Queries that must not appear in the matching documents and will contribute to scoring
=end
=begin
  Gets the mustnot queries
=end
  def must_not_expr
    return self.mustnot_queries
  end
=begin
  Adds a mustnot query
=end
  def must_not query_builder
    raise "Query in Must not clause cannot be nil" if query_builder.nil?
    @mustnot_queries.append(query_builder)
    return self
  end


########## MINIMUM SHOULD MATCH VALUE ##########
=begin
  Minimum Should match as interger or percentage
=end
=begin
  Gets the minimumShouldMatch value
=end
  def minimum_should_match_expr
    return @minimum_should_match
  end
=begin
  Sets the minimumShouldMatch value
=end
  def minimum_should_match value
    raise "Minimum Should match cannot be nil" if value.nil?
    @minimum_should_match = value
    return self
  end


########## HAS CLAUSES ##########
=begin
  Returns true iff this query builder has at least one should, must, must not or filter clause
=end
  def has_clauses?
    return !(@should_queries.nil? && @must_queries.nil? && @mustnot_queries.nil? && @filter_queries.nil?)
  end

end