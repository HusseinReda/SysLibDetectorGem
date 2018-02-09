module SysLibDetector
	class GemsCollector
		def self.get_all
			Bundler.load.specs.map(&:name)
		end
	end
end