# Namespace for classes handling the whole process of the gem 
# from collecting the projects' gem, going through system libraries retrieval, 
# till displaying the results or installing the required system libraries

module SysLibDetector
	# Class responsible for collecting the projects' local gems
	class GemsCollector
		# Getting all the projects' local gems
		def self.get_all
			Bundler.load.specs.map(&:name)
		end
	end
end