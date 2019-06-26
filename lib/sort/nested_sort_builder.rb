# Elasticsearch also supports sorting by fields that are inside one or more nested objects.
require_relative 'sort_builder'
class NestedSortBuilder < SortBuilder

  NAME = 'nested_sort'

=begin
  @params:
    filter: A filter that the inner objects inside the nested path should match with in order for its field values to be taken into account by sorting.
    max_children: The maximum number of children to consider per root document when picking the sort value.
    nested_sort: Same as top-level nested but applies to another nested path within the current nested object.
    path: Defines on which nested object to sort. The actual sort field must be a direct field inside this nested object.
=end
  
  def initialize path:
    @path = path
    @filter = nil
    @max_children = nil
    @nested_sort = nil
  end

  def query
    query = self.common_query
    query[:path] = @path
    query[:filter] = @filter.query if @filter.present?
    query[:nested] = @nested_sort.query if @nested_sort.present?
    query[:max_children] = @max_children if @max_children.present?
    return query
  end

# returns path
  def path_expr
    return @path
  end

# returns filter
  def filter_expr
    return @filter
  end
# sets filter
  def filter filter
    @filter = filter
    return self
  end

# returns max_children
  def max_children_expr
    return @max_children
  end
# sets max_children
  def max_children max_children
    @max_children = max_children
    return self
  end

# returns nested_sort
  def nested_sort_expr
    return @nested_sort
  end
# sets nested_sort
  def nested_sort nested_sort
    @nested_sort = nested_sort
    return self
  end

end