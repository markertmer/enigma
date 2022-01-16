require './helper.rb'

if ARGV.count != 2 ||
  !File.exist?(ARGV[0]) ||
  (ARGV[1].include?("/") &&
  !File.exist?(ARGV[1].split("/")[0..-2].join("/")))

  puts "INVALID INPUT\n- Make sure your source file is valid.\n- Make sure to use a valid filepath for your output.\nCOMMAND STRUCTURE:\n$ ruby encrypt.rb <source filepath> <output filepath>"
  exit
end

message = File.read(ARGV[0]).to_s
encrypted = Enigma.new.encrypt(message)

File.new(ARGV[1], "w+")
File.write(ARGV[1], encrypted[:encryption])

puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"
