require "spec_helper"

RSpec.describe FtpTime do	

	let(:timer) { FtpTime::Timer.new}
	let(:faketime) { DateTime.new(2017,12,11,11,9,45,0.375) }
	let(:exe_time) {DateTime.new(2017,12,11,11,9,46,0.375) }

	before do
		def set_faketime(faketime)
			timer.instance_eval do 
				@time_now = faketime
			end
		end
		set_faketime(faketime)
		
		t = timer
		FtpTime.class_eval do
			@timer = t
		end
	end

	describe FtpTime::Uploader do
		it "#exec" do
			expect(FtpTime::exec("****.ne.jp", "***user", "***pass", exe_time) do |upload|
				upload.binary = true
				upload.chdir = "/csv"
				upload.put = "README.md"
			end).not_to be nil
		end
		

		it "has a version number" do
			expect(FtpTime::VERSION).not_to be nil
		end
	end

	xdescribe FtpTime::Timer do
		describe "#start" do
			context "block_given? => false" do
				it "実行時間表示" do
					expect(timer.start).to eq "execute method 0 ago"
				end
			end
			context "block_given? => true" do
				it "ブロックの戻り値表示" do
					expect(timer.start do
						"test"
					end).to eq "test"
				end
			end
		end

		describe "#time_now" do
			it "FakeTime取得" do
				expect(timer.instance_eval do
					time_now 
				end).to eq faketime
			end
		end
	end
end
