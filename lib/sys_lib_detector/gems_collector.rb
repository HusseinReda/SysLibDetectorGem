module SysLibDetector
	class GemsCollector
		def get_all
			Bundler.load.specs.map(&:name)
		end
	end
end