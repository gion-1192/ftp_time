module FtpTime
	class Uploader < Net::FTP
		def params
			@params ||= {}
		end
			
		def upload
			@params.each do |method, arg|
				self.send(method.to_sym, arg)
				p method
			end
			quit
		end
	
		def method_missing(method, *args)
			if method.match(/(\w+)=$/)
				@params[$1] = args[0]
				return
			end

			raise "undefined #{method}"
		end

		def login(data)
			super(data[:user], data[:pass])
		end
	end
end
