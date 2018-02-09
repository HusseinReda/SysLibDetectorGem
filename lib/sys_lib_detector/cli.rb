require "thor"
require "sys_lib_detector"

module SysLibDetector
	class Cli < Thor
		desc "hello", "hamada text generator"
		def hello
			puts "Hello world!"
		end
	end
end