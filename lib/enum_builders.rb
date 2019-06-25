class EnumBuilders
	# Factory Pattern for all enum classes.

	def self.combine_functions
		return CombineFunctions
	end

	def self.fuzziness
		return Fuzziness
	end

	def self.score_modes
		return ScoreModes
	end

	def self.shape_relations
		return ShapeRelations
	end

	def self.distance_units
		return DistanceUnits
	end

	def self.zero_terms_query
		return ZeroTermsQuery
	end

	def self.geo_distance_types
		return GeoDistanceTypes
	end

	def self.geo_validation_methods
		return GeoValidationMethods
	end

end
