require 'spec_helper'

RSpec.describe 'aggregations' do

  before(:example) do
    # Script object
    @params = {"modifier": 2}
    @script = ::Misc::Script.new(id_or_code: "ctx._source.field1*modifier", params: @params, type: Enums::ScriptTypes.inline)

    # BucketOrder object
    @order1 = ::Misc::BucketOrder.new(field: 'field3', order: Enums::SortOrders.asc)
    @order2 = ::Misc::BucketOrder.new(field: 'field4')

    # ValuesSourceAggregationHelper fields
    @terms_agg = AggregationBuilders.terms(name: 'terms_agg').field('field1').script(@script).missing('val1')

    # TermsAggregationBuilder object
    @terms_agg = @terms_agg.include(['field1', 'field2', 'field3']).add_order(@order1).add_order(@order2).min_doc_count(10).size(5)
  end

  it 'should test terms aggregation' do
    # testing Script
    expect(@script.attributes.id_or_code).to eql("ctx._source.field1*modifier")
    expect(@script.attributes.params).to eql(@params)
    expect(@script.attributes.type.script_type).to eql(Enums::ScriptTypes.inline.script_type)
    expect(@script.attributes.lang).to eql('painless')

    # testing BucketOrder
    expect(@order1.attributes.field).to eql('field3')
    expect(@order1.attributes.order.sort_order).to eql(Enums::SortOrders.asc.sort_order)
    expect(@order2.attributes.field).to eql('field4')
    expect(@order2.attributes.order.sort_order).to eql(Enums::SortOrders.desc.sort_order)

    # testing name and type
    expect(@terms_agg.attributes.name).to eql('terms_agg')
    expect(@terms_agg.attributes.type).to eql('terms')
    
    # testing ValuesSourceAggregationHelper
    expect(@terms_agg.attributes.field).to eql('field1')
    expect(@terms_agg.attributes.script).to eql(@script)
    expect(@terms_agg.attributes.missing).to eql('val1')

    # testing TermsAggregationBuilder
    expect(@terms_agg.attributes.include).to eql(['field1', 'field2', 'field3'])
    expect(@terms_agg.attributes.order).to eql([@order1, @order2])
    expect(@terms_agg.attributes.min_doc_count).to eql(10)
    expect(@terms_agg.attributes.size).to eql(5)

    # testing query
    query = @terms_agg.attributes.query
    expect(query[:terms_agg][:terms][:field]).to eql('field1')
    expect(query[:terms_agg][:terms][:script][:source]).to eql("ctx._source.field1*modifier")
    expect(query[:terms_agg][:terms][:missing]).to eql('val1')
    expect(query[:terms_agg][:terms][:include]).to eql(['field1', 'field2', 'field3'])
    expect(query[:terms_agg][:terms][:order][0][:field3]).to eql('asc')
    expect(query[:terms_agg][:terms][:order][1][:field4]).to eql('desc')
    expect(query[:terms_agg][:terms][:min_doc_count]).to eql(10)
    expect(query[:terms_agg][:terms][:size]).to eql(5)
  end

  before(:example) do
    # FieldSortBuilder object
    @sort1 = SortBuilders.field_sort(field_name: 'field1').order(Enums::SortOrders.asc)
    @sort2 = SortBuilders.field_sort(field_name: 'field2').order(Enums::SortOrders.desc)

    # TopHitsAggregationBuilder object
    @top_hits_agg = AggregationBuilders.top_hits(name: 'top_hits_agg').size(5).add_sort(@sort1).add_sort(@sort2).source_include(['field1', 'field2'])
  end

  it "should test top hits aggregation" do
    # testing TopHitsAggregationBuilder
    expect(@top_hits_agg.attributes.size).to eql(5)
    expect(@top_hits_agg.attributes.sort).to eql([@sort1, @sort2])
    expect(@top_hits_agg.attributes.source_include).to eql(['field1', 'field2'])

    # testing query
    query = @top_hits_agg.attributes.query
    expect(query[:top_hits_agg][:top_hits][:size]).to eql(5)
    expect(query[:top_hits_agg][:top_hits][:sort][0][:field1][:order]).to eql(Enums::SortOrders.asc.sort_order)
    expect(query[:top_hits_agg][:top_hits][:sort][1][:field2][:order]).to eql(Enums::SortOrders.desc.sort_order)
    expect(query[:top_hits_agg][:top_hits][:_source][:include]).to eql(['field1', 'field2'])
  end

  before(:example) do
    # Range object
    @range1 = ::Misc::Range.new(key: 'older', from: '2016/02/01', to: '2016/02/30')
    @range2 = ::Misc::Range.new(key: 'newer', from: '2016/03/01')

    # DateRangeAggregationBuilder object
    @date_range_aggs = AggregationBuilders.date_range(name: 'date_range_aggs').keyed(true).add_range()
  end

  it "should test date range aggregation" do
  end

  before(:example) do
  end

  it "should test range aggregation" do
  end

end