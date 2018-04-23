class DocumentNotFoundException < StandardError

	def initialize(index, type, id)
    super("Document in index: #{index} with type: #{type} and id: #{id} not found")
  end

end