require 'json'

JSONFILE = "Gictionary.json"
file = File.read JSONFILE
data = JSON.parse(file)

data['pages'].each { |page|
  title = ''
  page['lines'].each { |line|
    if title == ''
      title = line
      next
    end
    break if line =~ /\[.*\]/
    break if line =~ /^\s/
    a = line.split(/\s+/)
    break if a.length < 2 || a.length > 3
    puts "#{a[0]} #{title} #{a[1]} #{a[2]}"
  }
}
