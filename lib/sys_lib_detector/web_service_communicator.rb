require 'rest-client'
require 'json'

module SysLibDetector
	# Handler for the communication with the web-service for retrieving 
	# the required system libraries
	class WebServiceCommunicator
		# Url for the web-service libraries retrieval endpoint
		SERVICE_URL = "https://sys-libraries.herokuapp.com/libraries"

		# Initializing the handler object, with a check for internet connectivity
		def initialize
			# checking internet connectivity
			raise Exception::NoInternetConnection if ping != :pong

			@url = SERVICE_URL
		end

		# Retrieving the required system libraries by sending a get request 
		# to the web-service with the gems' names and running operating system
		# @param gems_names [Array] The current project's gems' names
		# @param os_name [String] The operating system's name as a symbol (:linux, :osx, :windows)
		# @return [Json] The web-services's response, 
		# 	in format { gem_1: [a,b,c], gem_2: [x,y,z] }
		def retrieve_sys_libraries(gems_names, os_name)
			params = {
				gems: gems_names,
				os: os_name
			}
			response = JSON.parse(RestClient.get(@url, {params: params}))
		end

		private

			# Pinging google.com for checking the internet connectivity, by
			# making a simple get request to www.google.com
			def ping
				begin
					RestClient.get("https://www.google.com")
					return :pong
				rescue SocketError => e
					return e
				rescue Errno::ECONNREFUSED => e
					return e
				end
			end
	end
end