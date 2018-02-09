module SysLibDetector
	# Namespace for the exceptions classes 
	module Exception
		# Standard error exception
		class Error < StandardError
		end

		# No internet connectivity exception
		class NoInternetConnection < Error
		end
	end
end
