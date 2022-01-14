require './helper.rb'

ciphertext = File.read(ARGV[0]).to_s

decrypted = Enigma.new.decrypt(ciphertext, ARGV[2], ARGV[3])

# File.write(ARGV[1], decrypted[:decryption], "w+")

File.new(ARGV[1], "w+")
File.write(ARGV[1], decrypted[:decryption])

puts "Created #{ARGV[1]} with the key #{decrypted[:key]} and date #{decrypted[:date]}"




# Test Commands
#
# ruby decrypt.rb ./file/test_encryption.txt ./file/test_decipheration.txt 82648 240818
