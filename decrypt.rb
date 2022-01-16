require './helper.rb'

input_filter

ciphertext = File.read(ARGV[0]).to_s
decrypted = Enigma.new.decrypt(ciphertext, ARGV[2], ARGV[3])

File.new(ARGV[1], "w+")
File.write(ARGV[1], decrypted[:decryption])

puts "Created #{ARGV[1]} with the key #{decrypted[:key]} and date #{decrypted[:date]}"

def input_filter
  if ARGV.count != 4 || !File.exist?(ARGV[0]) || (ARGV[1].include?("/") && !File.exist?(ARGV[1].split("/")[0..-2].join("/"))) || ARGV[2].length != 5 || ARGV[3].length != 6 || ARGV[2].to_i.to_s != ARGV[2] || ARGV[3].to_i.to_s != ARGV[3]
    puts "INVALID INPUT\n- Make sure your source file is valid.\n- Make sure to use a valid filepath for your output.\n- The key must be exactly 5 digits, numbers only.\n- Enter a date using 'DDMMYY' formatting. 6 digits, numbers only.\nCOMMAND STRUCTURE:\n$ ruby encrypt.rb <source filepath> <output filepath> <key> <date>"
    exit
  end
end
