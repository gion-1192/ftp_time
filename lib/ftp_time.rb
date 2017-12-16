require 'date'
require 'net/ftp'

require "ftp_time/version"
require "ftp_time/uploader"
require 'ftp_time/timer'

module FtpTime
	class << self
		def timer
			@timer ||= Timer.new
		end

		def uploader
			@uploader ||= Uploader.new
		end

		def exec(domain, user, password, exe_time)
			uploader.params.merge!(
				{ connect: domain, 
			    login: { user: user,
							     pass: password }
				})
			
			timer.exe_time = exe_time
			
			yield uploader if block_given?
				
			@timer.start do 
				uploader.upload
			end
		end
	end
end

