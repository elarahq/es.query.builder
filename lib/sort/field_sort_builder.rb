# A sort builder to sort based on a document field.
require_relative 'sort_builder'
class FieldSortBuilder < SortBuilder

  NAME = "field_sort"

  def initialize field_name:
    @field_name = field_name
  end

  def query
    query = {}
    field_query = self.common_query
    field_query[:mode] = @mode if @mode.present?
    field_query[:missing] = @missing if @missing.present?
    field_query[:unmapped_type] = @unmapped_type if @unmapped_type.present?
    field_query[:nested] = @nested_sort.query if @nested_sort.present?
    query[@field_name.intern] = field_query
    return query
  end

# returns field_name
  def field_name_expr
    return @field_name
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

# returns missing
  def missing_expr
    return @missing
  end
# sets missing
  def missing missing
    @missing = missing.is_a?(Missing) ? missing.missing : missing
    return self
  end

# returns sort_mode
  def sort_mode_expr
    return @sort_mode
  end
# sets sort_mode
  def sort_mode sort_mode
    @sort_mode = sort_mode.sort_mode
    return self
  end

# returns unmapped_type
  def unmapped_type_expr
    return  @unmapped_type
  end
# sets unmapped_type
  def unmapped_type unmapped_type
    @unmapped_type = unmapped_type
    return self
  end

end