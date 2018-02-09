module SysLibDetector
	# Class responsible for displaying the results of the 
	# command line interface class
	class Displayer
		# Displaying the system libraries retrieved
		# @param response [Json] The json response of web-service 
		#	in format { gem_1: [a,b,c], gem_2: [x,y,z] }
		# @param gems [Array] The current project's gems' names
		def self.diplay_list_sys_libs(response, gems)
			display_header(response, gems)

			response.each do |gemm, libraries|
				puts "#{gemm}:"
				libraries.each do |library|
					puts "  #{library}"
				end
			end

			# display_footer if response.count > 0
		end

		private

			def self.gems_with_libraries_count(response)
				return response.keys.count
			end

			# Displaying the header message after recieving the web-service response
			# @param response [Json] The json response of web-service 
			#	in format { gem_1: [a,b,c], gem_2: [x,y,z] }
			# @param gems [Array] The current project's gems' names
			def self.display_header(response, gems)
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

			# def self.display_footer
			# 	puts "\nTo install the required system libraries listed, run 'sys-lib-detector install-sys-libs'"
			# end
	end
end