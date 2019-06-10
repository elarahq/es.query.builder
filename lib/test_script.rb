Dir["/root/housing/es.query.builder/lib/*_helper.rb"].each {|file| require file }
Dir["/root/housing/es.query.builder/lib/*_builder.rb"].each {|file| require file }
Dir["/root/housing/es.query.builder/lib/*_builders.rb"].each {|file| require file }
require 'active_support/all'
# t1 = AggregationBuilders.terms('term1').field('age').include(['anu1', 'anu2', 'anu3']).add_order('anu1').add_order('anu4')
# puts t1.get_query
# t2 = AggregationBuilders.filter('filter1', {:bool => {:must => [{:f1 => 'v1'}]}}).sub_aggregation(t1)
# puts t2.get_query
# t3 = AggregationBuilders.geohash_grid('geo1').size(10).precision(5).sub_aggregation(t1)
# puts t3.get_query
# t4 = AggregationBuilders.top_hits('thits1').add_sort(:f1).add_sort(:f2, :asc).source(['a1', 'a2']).sub_aggregation(t1)
# puts t4.get_query
# t5 = AggregationBuilders.reverse_nested('rnested1').sub_aggregation(t1)
# puts t5.get_query
# t6 = AggregationBuilders.nested('nested1', 'room_types').sub_aggregation(t5)
# puts t6.get_query
# t7 = AggregationBuilders.date_histogram('dhist1').field('age').interval('M').add_order('anu1').add_order('anu4')
# puts t7.get_query
# t8 = AggregationBuilders.histogram('hist1').field('age').interval('M').add_order('anu1').add_order('anu4')
# puts t8.get_query
# t9 = AggregationBuilders.date_range('drange1').field('start_date').add_range("2016/02/01", "2017/02/01", 'older').add_range("2017/02/01", nil)
# puts t9.get_query
# t10 = AggregationBuilders.range('range1').field('age').add_range(10, 100, 'older').add_range(200, nil).keyed(true)
# puts t10.get_query
t11 = AggregationBuilders.max('max1').field('age').missing(10)
puts t11.get_query
