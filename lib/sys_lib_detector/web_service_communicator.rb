module SysLibDetector
	class WebServiceCommunicator
		WEB_SERVICE_URL = "https://sys-libraries.herokuapp.com"

		def initialize
			# checking internet connectivity
			return "Please check your internet connectivity" if ping != :pong

			@url = WEB_SERVICE_URI
		end

		def retrieve_dependencies(gems_names, os_name)
			params = {
				os: os_name,
				gems: gems_names
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