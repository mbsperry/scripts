#!/usr/bin/ruby -w
fileName = ARGV[0]
file = File.open(fileName, "r")
file.each do |line|
	next if line[/^\n/]
	line.gsub!(/tags:.*/, "")
	line.gsub!(/^ ?: ?/, "")
	line.gsub!(/\/:/, "")
	line.gsub!(/\[([^\]]*)\]/, '\1')
	puts line
end

