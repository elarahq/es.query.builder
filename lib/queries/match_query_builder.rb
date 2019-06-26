# Match query is a query that analyzes the text and constructs a query as the result of the analysis.
require_relative 'query_builder'
class MatchQueryBuilder < QueryBuilder
=begin
 @params: analyzer, auto_generate_synonyms_phrase_query, cutoff_frequency, field_name, fuzziness, fuzzy_transposition,
          lenient, max_expansions, minimum_should_match, operator, prefix_length, value, zero_terms_query
    analyzer: analyzer to be used for this query
    auto_generate_synonyms_phrase_query: The match query supports multi-terms synonym expansion with the synonym_graph token filter.
                                         When this filter is used, the parser creates a phrase query for each multi-terms synonyms.
                                         For example, the following synonym: "ny, new york" would produce:
                                         (ny OR ("new york"))
    cutoff_frequency: cutoff value in [0..1] (or absolute number >=1) representing the maximum threshold of a terms document frequency 
                      to be considered a low frequency term.
    field_name: name of the field to be queried
    fuzziness: fuzziness used when evaluated to a fuzzy query type
    fuzzy_transposition: fuzzy transpositions (ab → ba) are allowed by default but can be disabled by setting fuzzy_transpositions to false
    max_expansions: max_expansions limit the number of matching docs that will be returned
    minimum_should_match: minimum number of cases to match in case of or query
    value: value to be matched in that field in the documents
    zero_terms_query: If the analyzer used removes all tokens in a query like a stop filter does, the default behavior is to match no documents at all.
                      In order to change that the zero_terms_query option can be used, which accepts none (default) and all which corresponds to a match_all query.
    fuzzy_prefix_length: prefix length provides the number of characters from beginning that have to be exactly matched
=end

  NAME = "match"

  def initialize field_name: , value: nil
    @field_name = field_name
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
    field_options[:fuzziness] = @fuzziness if @fuzziness.present?
    match_query[@field_name.to_s.intern] = field_options
    query[name.intern] = match_query
    return query
  end

########## FIELD NAME ##########
# returns field_name
  def field_name_expr
    return @field_name
  end

########## FIELD VALUE ##########
# returns value
  def value_expr
    return @value
  end

########## SEARCH ANALYZER ##########
# return analyzer
  def analyzer_expr
    return @analyzer
  end
# sets analyzer
  def analyzer value
    @analyzer = value
    return self
  end


########## AUTO GENERATE SYNONYMS PHRASE QUERY ##########
# returns auto_generate_synonyms_phrase_query
  def auto_generate_synonyms_phrase_query_expr
    return @auto_generate_synonyms_phrase_query
  end
# sets auto_generate_synonyms_phrase_query
  def auto_generate_synonyms_phrase_query value
    @auto_generate_synonyms_phrase_query = value
    return self
  end


########## CUTOFF FREQUENCY ##########
# returns cutoff_frequency
  def cutoff_frequency_expr
    return @cutoff_frequency
  end
# sets cutoff_frequency
  def cutoff_frequency value
    @cutoff_frequency = value
    return self
  end


########## FUZZINESS VALUE ##########
# returns fuzziness
  def fuzziness_expr
    return @fuzziness
  end
# sets fuzziness
  def fuzziness fuzziness
    @fuzziness = fuzziness.fuzziness
    return self
  end

########## PREFIX LENGTH ########
# returns prefix_length
  def fuzzy_prefix_length_expr
    return @prefix_length
  end
# sets prefix_length
  def fuzzy_prefix_length value
    @prefix_length = value
    return self
  end

########## MAX EXPANSIONS ##########
# returns max_expansions
  def max_expansions_expr
    return @max_expansions
  end
# sets max_expansions
  def max_expansions value
    @max_expansions = value
    return self    
  end

########## FUZZY TRANSPOSITIONS ##########
# returns fuzzy_transpositions
  def fuzzy_transpositions_expr
    return @fuzzy_transpositions
  end
# sets fuzzy_transpositions
  def fuzzy_transpositions value
    @fuzzy_transpositions = value
    return self
  end

########## MINIMUM SHOULD ##########
# returns minimum_should_match
  def minimum_should_match_expr
    return @minimum_should_match
  end
# sets minimum_should_match
  def minimum_should_match value
    @minimum_should_match = value
    return self
  end

########## ZERO TERMS ##########
# returns zero_terms_query
  def zero_terms_query_expr
    return @zero_terms_query
  end
# sets zero_terms_query
  def zero_terms_query zero_terms_query
    @zero_terms_query = zero_terms_query.zero_term
    return self
  end

end


