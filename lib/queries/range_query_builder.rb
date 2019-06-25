# Matches documents with fields that have terms within a certain range.
require_relative 'query_builder'
class RangeQueryBuilder < QueryBuilder

  NAME = "range"

=begin
  params:
    @gt: Greater-than
    @gte: Greater-than or equal to
    @lt: Less-than
    @lte: Less-than or equal to
    @format: Formatted dates will be parsed using the format specified on the date field by default, 
             but it can be overridden by passing the format parameter to the range query
    @time_zone: Dates can be converted from another timezone to UTC either by specifying the time zone in the date value itself 
                (if the format accepts it), or it can be specified as the time_zone parameter

    @relation: range queries can be used on fields of type range, allowing to match a range specified in the query with a range field value in the document.
               The relation parameter controls how these two ranges are matched:
                WITHIN
                  Matches documents who’s range field is entirely within the query’s range.
                CONTAINS
                  Matches documents who’s range field entirely contains the query’s range.
                INTERSECTS
                  Matches documents who’s range field intersects the query’s range. This is the default value when querying range fields.
  
  Date math and rounding
    When using date math to round dates to the nearest day, month, hour, etc, the rounded dates depend on whether the ends of the ranges 
    are inclusive or exclusive.Rounding up moves to the last millisecond of the rounding scope, and rounding down to the first millisecond 
    of the rounding scope. For example:
      gt
        Greater than the date rounded up: 2014-11-18||/M becomes 2014-11-30T23:59:59.999, ie excluding the entire month.
      gte
        Greater than or equal to the date rounded down: 2014-11-18||/M becomes 2014-11-01, ie including the entire month.
      lt
        Less than the date rounded down: 2014-11-18||/M becomes 2014-11-01, ie excluding the entire month.
      lte
        Less than or equal to the date rounded up: 2014-11-18||/M becomes 2014-11-30T23:59:59.999, ie including the entire month.
=end

  def initialize field_name:
    @field_name = field_name
    @gt= nil
    @gte= nil
    @lt= nil
    @lte= nil
    @format= nil
    @time_zone = nil
    @relation= nil
  end

  def query
    query = {}
    range_query = {}
    field_options = self.common_query
    field_options[:gt] = @gt if @gt.present?
    field_options[:gte] = @gte if @gte.present?
    field_options[:lt] = @lt if @lt.present?
    field_options[:lte] = @lte if @lte.present?
    field_options[:format] = @format if @format.present?
    field_options[:time_zone] = @time_zone if @time_zone.present?
    field_options[:relation] = @relation if @relation.present?
    range_query[@field_name.intern] = field_options
    query[name.intern] = range_query
    return query
  end

# returns field_name
  def field_name_expr
    return @field_name
  end

########## Greater Than ##########
# returns gt
  def gt_expr
    return @gt
  end
# sets gt
  def gt value
    @gt = value
    return self
  end

########## Greater Than Or Equal To ##########
# returns gte
  def gte_expr
    return @gte
  end
# sets gte
  def gte value
    @gte = value
    return self
  end

########## Less Than ##########
# return lt
  def lt_expr
    return @lt
  end
# sets lt
  def lt value
    @lt = value
    return self
  end

########## Less Than Or Equal To ##########
# returns lte
  def lte_expr
    return @lte
  end
# sets lte
  def lte value
    @lte = value
    return self
  end

########## Format ##########
# returns format
  def format_expr
    return @format
  end
# sets format
  def format value
    @format = value
    return self
  end

########## Time Zone ##########
# returns time_zone
  def time_zone_expr
    return @time_zone
  end
# sets time_zone
  def time_zone value
    @time_zone = value
    return self
  end

########## RANGE RELATION ##########
# returns relation
  def relation_expr
    return @relation
  end
# sets relation, input: ShapeRelation object
  def relation shape_relation
    @relation = shape_relation.relation
    return self
  end

end

