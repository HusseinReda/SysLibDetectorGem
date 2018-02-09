require 'system'

module SysLibDetector
	# Class responsible for getting information about the current system
	class SystemDetector
		# Getting the running operating system's name
		def self.get_os_name
			return System::OS.name
		end
	end
end