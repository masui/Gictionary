puts "var _dict = ["
ARGF.each { |line|
  (roma, word, inc, outc)  = line.chomp.split(/\t/)
  word.gsub(/"/,'\\"')
  puts "  [\"#{roma}\", \"#{word}\", #{inc}, #{outc ? outc : 'null'}],"
}
puts "];"

