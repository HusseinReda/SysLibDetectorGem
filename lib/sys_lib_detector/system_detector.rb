require 'system'

module SysLibDetector
	class SystemDetector
		def self.get_os_name
			return System::OS.name
		end
	end
end