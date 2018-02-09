require 'rest-client'
require 'json'

module SysLibDetector
	class WebServiceCommunicator
		SERVICE_URL = "https://sys-libraries.herokuapp.com/libraries"

		def initialize
			# checking internet connectivity
			raise Exception::NoInternetConnection if ping != :pong

			@url = SERVICE_URL
		end

		def retrieve_sys_libraries(gems_names, os_name)
			params = {
				gems: gems_names,
				os: os_name
			}
			response = JSON.parse(RestClient.get(@url, {params: params}))
		end

		private
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