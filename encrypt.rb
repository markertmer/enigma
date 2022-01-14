require './helper.rb'

message = File.read(ARGV[0]).to_s

encrypted = Enigma.new.encrypt(message)

File.new(ARGV[1], "w+")
File.write(ARGV[1], encrypted[:encryption])

puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"

# Test Commands
#
# ruby encrypt.rb ./file/test_message.txt ./file/test_encryption.txt
