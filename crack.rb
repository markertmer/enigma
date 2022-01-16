require './helper.rb'

if ARGV.count != 3 ||
  !File.exist?(ARGV[0]) ||
  (ARGV[1].include?("/") &&
  !File.exist?(ARGV[1].split("/")[0..-2].join("/"))) ||
  ARGV[2].length != 6 ||
  ARGV[2].to_i.to_s.rjust(6, "0") != ARGV[2]

  puts "INVALID INPUT\n- Make sure your source file is valid.\n- Make sure to use a valid filepath for your output.\n- Enter a date using 'DDMMYY' formatting. 6 digits, numbers only.\nCOMMAND STRUCTURE:\n$ ruby crack.rb <source filepath> <output filepath> <date>"
  exit
end


ciphertext = File.read(ARGV[0]).to_s.chomp
cracked = Enigma.new.crack(ciphertext, ARGV[2])

File.new(ARGV[1], "w+")
File.write(ARGV[1], cracked[:decryption])

puts "Created #{ARGV[1]} with the cracked key #{cracked[:key]} and date #{cracked[:date]}"
