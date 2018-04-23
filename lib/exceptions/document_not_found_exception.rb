# Exception class used when document is not found in ES
class DocumentNotFoundException < StandardError

  def initialize(index, type, id)
    super("Document in index: #{index} with type: #{type} and id: #{id} not found")
  end

end