class ScriptBuilders

	def self.script_builder *args
		return Scripts::Script.new *args
	end

end