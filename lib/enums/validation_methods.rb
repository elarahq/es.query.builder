# frozen_string_literal: true

module Enums
  # This enum is used to determine how to deal with invalid
  # geo coordinates in geo related queries: On STRICT validation
  # invalid coordinates cause an exception to be thrown.
  # On IGNORE_MALFORMED invalid coordinates are being accepted.
  # On COERCE invalid coordinates are being corrected to
  # the most likely valid coordinate.
  class ValidationMethods
    # @!visibility protected
    VALIDATION_METHODS = { coerce: 'COERCE',
                           ignore_malformed: 'IGNORE_MALFORMED',
                           strict: 'STRICT' }.freeze
    # @!visibility protected
    attr_reader :validation_method
    # @!visibility protected
    VALIDATION_METHODS.each do |validation_method, es_value|
      define_singleton_method(validation_method) do
        new(es_value)
      end
    end

    # @!scope class
    # @!method coerce
    # @return [ValidationMethods] ValidationMethods object
    #   corresponding to elasticsearch option of 'COERCE'

    # @!scope class
    # @!method ignore_malformed
    # @return [ValidationMethods] ValidationMethods object
    #   corresponding to elasticsearch option of 'IGNORE_MALFORMED'

    # @!scope class
    # @!method strict
    # @return [ValidationMethods] ValidationMethods object
    #   corresponding to elasticsearch option of 'STRICT'

    # @!visibility protected
    def initialize(validation_method)
      @validation_method = validation_method
    end
  end
end
