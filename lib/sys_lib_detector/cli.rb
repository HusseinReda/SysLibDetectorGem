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
				display_response(response, gems)
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

			def display_response(response, gems)
				response = clean_response(response)

				display_header(response, gems)

				response.each do |gemm, libraries|
					puts "#{gemm}:"
					libraries.each do |library|
						puts "  #{library}"
					end
				end

				# display_footer if response.count > 0
			end

			def gems_with_libraries_count(response)
				return response.keys.count
			end

			def clean_response(json_object)
				json_object.delete_if {|key, value| value.nil? || value.empty?}
			end

			def display_header(response, gems)
				gems_found_count = gems_with_libraries_count(response)
				all_found = gems_found_count == gems.count

				if(gems_found_count == 0)
					puts "No system libraries found for your gems, you can contribute by adding libraries!"
					puts "For more details check https://github.com/HusseinReda/SysLibDetectorGem#contributing"
					return
				end

				if(all_found)
					puts "Required system libraries found for all your gems!"
				else
					puts "Required system libraries found for gems: #{response.keys.join(", ")}"
				end
			end

			# def display_footer
			# 	puts "\nTo install the required system libraries listed, run 'sys-lib-detector install-sys-libs'"
			# end
	end
end