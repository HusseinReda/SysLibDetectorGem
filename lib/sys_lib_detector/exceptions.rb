module SysLibDetector
	module Exception
		class Error < StandardError
		end

		class NoInternetConnection < Error
		end
	end
end
