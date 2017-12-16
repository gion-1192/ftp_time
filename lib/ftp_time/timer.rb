module FtpTime
	class Timer
		attr_accessor :exe_time
		
		def start
			raise "undefined exe_time" if @exe_time.nil?

			differ = min_conversion(@exe_time - time_now)
			sleep differ unless differ <= 0

			if block_given?
				yield
			else
				"execute method #{differ} ago"
			end
		end
		
		private
		def min_conversion(time)
			(time * 24 * 60 * 60).to_i
		end

		def time_now
			@time_now ||= DateTime.now
		end
	end
end


