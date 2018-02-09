require "thor"
require "sys_lib_detector"

module SysLibDetector
	# The command-line interface class, responsible for the commands of running 
	# the gem's funcionalities, using Thor's gem
	class Cli < Thor

		desc "list_all_gems", "Listing all the local gems existing in the porject"
		# Listing the local gems existing in the porject
		def list_all_gems
			gems = get_gems
			if gems.empty?
				puts "You don't have any gems installed"
			else
				puts gems
			end
		end

		desc "list_sys_libs", "Retrieving gems' dependant system libraries "
		# Retrieving the required system libraries for the project's local gems via 
		# sending the retrieval request to the web-service, and then displaying 
		# it in a friendly way using the Displayer class
		def list_sys_libs
			gems = get_gems
			os = get_os_name

			begin
				web_service_handler = get_web_service_handler

				response = web_service_handler.retrieve_sys_libraries(gems, os)
				response = clean_response(response)

				Displayer::diplay_list_sys_libs(response, gems)

			rescue Exception::NoInternetConnection
				abort "Please check your internet connectivity"
			rescue => e
				abort e.message
			end
		end

		desc "install_sys_libs", "Installing the required gems' dependant system libraries "
		# Installing the required system libraries for the project's local gems via 
		# sending the retrieval request to the web-service, and then installing the 
		# system libraries included in the response
		def install_sys_libs
			gems = get_gems
			os = get_os_name

			begin
				web_service_handler = get_web_service_handler

				response = web_service_handler.retrieve_sys_libraries(gems, os)
				response = clean_response(response)

				libraries = get_libraries(response)

				Displayer::display_header(response, gems)

				# if count == 0 message is already handled in the diplay header
				if(libraries.count > 0)
					installer = SysLibDetector::Installer.new
					installer.install(libraries)
				end

			rescue Exception::NoInternetConnection
				abort "Please check your internet connectivity"
			rescue => e
				abort e.message
			end
		end

		private
			# private method for getting the project's local gems
			def get_gems
				return GemsCollector.get_all
			end

			# private method for getting the running operating system's name
			def get_os_name
				return SystemDetector.get_os_name
			end

			# private method for initializing a new handler for the web-service
			def get_web_service_handler
				return WebServiceCommunicator.new
			end

			# private method for cleaning up the web-service's response from empty 
			# values, for gems that exist in the web-service but doesn't have 
			# libraries attached yet
			# @param json_object [Json] The json response of web-service 
			def clean_response(json_object)
				return json_object.delete_if {|key, value| value.nil? || value.empty?}
			end

			# private method for extracting the system libraries from the reponse
			# @param response [Json] The json response of web-service 
			def get_libraries(response)
				return response.values.flatten
			end

	end
end