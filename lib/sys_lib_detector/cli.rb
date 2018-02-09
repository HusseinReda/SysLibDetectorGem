require "thor"
require "sys_lib_detector"

module SysLibDetector
	class Cli < Thor

		desc "list_all_gems", "listing all the local gems existing in the porject"
		def list_all_gems
			gems = get_gems
			if gems.empty?
				puts "You don't have any gems installed"
			else
				puts gems
			end
		end

		desc "list_sys_libs", "Retrieving gems' dependant system libraries "
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
			end
		end

		private
			def get_gems
				GemsCollector.get_all
			end

			def get_os_name
				SystemDetector.get_os_name
			end

			def get_web_service_handler
				WebServiceCommunicator.new
			end

			def clean_response(json_object)
				json_object.delete_if {|key, value| value.nil? || value.empty?}
			end
	end
end