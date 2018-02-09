require "sys_lib_detector"

module SysLibDetector
	# Class responsible for installing the retrieved system libraries
	class Installer
		# Available operating systems for installing the libraries are
		# linux and macos only.
		AVAILABLE_OS = [:linux, :osx]

		# Initializing the installer object with the current os
		def initialize
			@os_name = get_os_name
		end

		# Installing the required system libraries, packager specified 
		# according to the current operating system, showing info about the 
		# status of the libraries, whether installed or not
		# @param libraries [Array] Retrieved required system libraries
		def install(libraries)
			# Abort with a friendly message if the running OS is not supported yet
			abort "We're sorry but currently we don't support #{@os_name} package installation" if(!is_os_available?(@os_name))

			# Message shown handled by the displayer already
			abort if libraries.count == 0
			installed_libraries = []
			failed_libraries = []

			libraries.each do |library|
				installed = self.send("#{@os_name}_installer", library)
				if(installed == true)
					installed_libraries << library
				else
					failed_libraries << library
				end
			end

			if(failed_libraries.count > 0)
				abort "#{failed_libraries.count} libraries failed to be installed: #{failed_libraries}"
			else
				abort "#{installed_libraries.count} libraries installed successfully!"
			end
		end

		private
			# private method for getting the running operating system's name
			def get_os_name
				return SystemDetector.get_os_name
			end

			# private method for checking the availability of the operating system
			def is_os_available?(os_name)
				return AVAILABLE_OS.include?(os_name)
			end

			# private method for running linux (apt) installing command
			def linux_install(package)
				system("sudo apt-get -y install #{package}")
			end

			# private method for running MacOS (homebrew) installing command
			def osx_installer(package)
				system("brew install #{package}")
			end

	end
end