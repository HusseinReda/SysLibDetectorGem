module SysLibDetector
	# Namespace for the exceptions classes 
	module Exception
		class Error < StandardError
		end

		class NoInternetConnection < Error
		end
	end
end
