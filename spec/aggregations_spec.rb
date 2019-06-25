require 'spec_helper'

RSpec.describe 'aggregations' do

  before(:example) do
    @script = ::Scripts::Script.new("ctx._source.field1*modifier", {"modifier": 2}, :INLINE)
    @terms_agg = AggregationBuilders.terms('terms_agg').field('field1').script(@script).missing('val1').include(['field1', 'field2', 'field3']).add_order('field3', :asc).add_order('field4').min_doc_count(10).size(5)
  end

  it 'should test terms aggregation' do
    query = @terms_agg.get_query
    expect(query[:terms_agg][:terms][:field]).to eql('field1')
    expect(query[:terms_agg][:terms][:script][:source]).to eql("ctx._source.field1*modifier")
    expect(query[:terms_agg][:terms][:include]).to eql(['field1', 'field2', 'field3'])
    expect(query[:terms_agg][:terms][:order][0][:field3]).to eql(:asc)
    expect(query[:terms_agg][:terms][:order][1][:field4]).to eql(:desc)
    expect(query[:terms_agg][:terms][:min_doc_count]).to eql(10)
    expect(query[:terms_agg][:terms][:size]).to eql(5)
  end

end