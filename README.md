# Elastic Search Query Builder
A gem to build standard elastic search queries.

## Installation
```ruby
gem 'es_query_builder'
```
And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install es_query_builder

Require the gem in you application
```ruby
require 'es_query_builder'
```

# Getting Started
A sample bool query structure
```ruby
ElasticSearchQuery.get_bool_filter_structure
```

> Description: Returns a bool query structure containing should, must, must_not clauses
returned structure:
```ruby
{
  bool: {
    must: [],
    should: [],
    must_not: []
  }
}
```

Fetching Data from Elastic Search
```ruby
bool_structure = ElasticSearchQuery.get_bool_filter_structure
term_filter = ElasticSearchQuery.get_term_filter_query("name", "sample")
bool_structure[:bool][:must] << term_filter
main_query = {query: bool_structure}
client = FetchEsData.new("localhost", "9200")
response_code, body = client.fetch_shortlisted_data_from_es(query: main_query, index_name: "index_name", type_name: "type_name", extension: '_search')
```

> the response code and body (along with the related documents) are returned.

Indexing Data with Elastic Search
```ruby
data = [ {update:{_index: index, _type: _doc, _id: 23, data: {doc: data }}}, 
		 {index: {_index: index2, _type: _doc, _id: 28, data: data}}
	   ]
indexer = Indexer.new("localhost", "9200")
indexer.bulk_index(data)
```

> multiple documents can be indexed this way.

# Author
Mohib Yousuf @mohibyousuf / https://github.com/mohibyousuf
Mohit Ojha @mohitrgiit / https://github.com/mohitrgiit

# Full API Doc
Please refer: 
