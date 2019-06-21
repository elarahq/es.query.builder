class MatchQueryBuilder < QueryBuilder

=begin
  Match query is a query that analyzes the text and constructs a query as the result of the analysis.
=end
=begin
 @params: analyzer, auto_generate_synonyms_phrase_query, cutoff_frequency, field_name, fuzziness, fuzzy_transposition,
          lenient, max_expansions, minimum_should_match, operator, prefix_length, value, zero_terms_query
=end

  NAME = "match"

  attr_reader :field_name, :value

  def initialize field, value
    @field_name = field
    @value = value
    @zero_terms_query = nil
    @analyzer = nil
    @auto_generate_synonyms_phrase_query = nil
    @cutoff_frequency = nil
    @fuzziness = nil
    @fuzzy_transpositions = nil
    @max_expansions = nil
    @minimum_should_match = nil
    @operator = nil
    @prefix_length = nil
    @zero_terms_query = nil
  end

  def query
    query = {}
    match_query = {}
    field_options = self.common_query
    field_options[:query] = @value
    field_options[:operator] = @operator if @operator.present?
    field_options[:analyzer] = @analyzer if @analyzer.present?
    field_options[:auto_generate_synonyms_phrase_query] = @auto_generate_synonyms_phrase_query if @auto_generate_synonyms_phrase_query.present?
    field_options[:cutoff_frequency] = @cutoff_frequency if @cutoff_frequency.present?
    field_options[:fuzzy_prefix_length] = @fuzzy_prefix_length if @fuzzy_prefix_length.present?
    field_options[:max_expansions] = @max_expansions if @max_expansions.present?
    field_options[:fuzzy_transpositions] = @fuzzy_transpositions if @fuzzy_transpositions.present?
    field_options[:minimum_should_match] = @minimum_should_match if @minimum_should_match.present?
    field_options[:zero_terms_query] = @zero_terms_query if @zero_terms_query.present?
    field_options.merge!(@fuzziness.settings) if @fuzziness.present?
    match_query[@field_name.intern] = field_options
    query[name.intern] = match_query
    return query
  end

########## SEARCH ANALYZER ##########
# Analyzer to be used for this query
# Return Analyzer
  def analyzer_expr
    return @analyzer
  end
# Sets Analyzer
  def analyzer value
    @analyzer = value
    return self
  end


########## AUTO GENERATE SYNONYMS PHRASE QUERY ##########

# Returns auto_generate_synonyms_phrase_query
  def auto_generate_synonyms_phrase_query_expr
    return @auto_generate_synonyms_phrase_query
  end
# Sets auto_generate_synonyms_phrase_query
  def auto_generate_synonyms_phrase_query value
    @auto_generate_synonyms_phrase_query = value
    return self
  end


########## CUTOFF FREQUENCY ##########
=begin
  cutoff value in [0..1] (or absolute number >=1) representing the maximum threshold of a terms document frequency 
  to be considered a low frequency term.
=end
# Returns cutoff_frequency
  def cutoff_frequency_expr
    return @cutoff_frequency
  end
# Sets cutoff_frequency
  def cutoff_frequency value
    @cutoff_frequency = value
    return self
  end


########## FUZZINESS VALUE ##########
# fuzziness used when evaluated to a fuzzy query type
# Returns fuzziness
  def fuzziness_expr
    return @fuzziness
  end
# Sets fuzziness
  def fuzziness fuzziness
    @fuzziness = fuzziness
    return self
  end

########## PREFIX LENGTH ########
# prefix length provides the number of characters from beginning that have to be exactly matched
# Returns prefix_length
  def fuzzy_prefix_length_expr
    return @prefix_length
  end
# Sets prefix_length
  def fuzzy_prefix_length value
    @prefix_length = value
    return self
  end

########## MAX EXPANSIONS ##########
# max_expansions limit the number of matching docs that will be returned
# Returns max_expansions
  def max_expansions_expr
    return @max_expansions
  end
# Sets max_expansions
  def max_expansions value
    @max_expansions = value
    return self    
  end

########## FUZZY TRANSPOSITIONS ##########
# Fuzzy transpositions (ab → ba) are allowed by default but can be disabled by setting fuzzy_transpositions to false.
# Returns fuzzy_transpositions
  def fuzzy_transpositions_expr
    return @fuzzy_transpositions
  end
# Sets fuzzy_transpositions
  def fuzzy_transpositions value
    @fuzzy_transpositions = value
    return self
  end

########## MINIMUM SHOULD ##########
# minimum number of cases to match in case of or query
# Returns minimum_should_match
  def minimum_should_match_expr
    return @minimum_should_match
  end
# Sets minimum_should_match
  def minimum_should_match value
    @minimum_should_match = value
    return self
  end

########## ZERO TERMS ##########
=begin 
  If the analyzer used removes all tokens in a query like a stop filter does, the default behavior is to match no documents at all.
  In order to change that the zero_terms_query option can be used, which accepts none (default) and all which corresponds to a match_all query.
=end
# Returns zero_terms_query
  def zero_terms_query_expr
    return @zero_terms_query
  end
# Sets zero_terms_query
# Allowed Values: [ZeroTermsQuery.none, ZeroTermsQuery.all]
  def zero_terms_query zero_terms_query_instance
    @zero_terms_query = zero_terms_query_instance.zero_terms
    return self
  end

end


