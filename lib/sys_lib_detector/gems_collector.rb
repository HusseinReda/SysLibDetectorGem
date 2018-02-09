module SysLibDetector
	# Class responsible for collecting the projects' local gems
	class GemsCollector
		# Getting all the projects' local gems
		def self.get_all
			Bundler.load.specs.map(&:name)
		end
	end
end