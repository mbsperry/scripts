#!/usr/bin/ruby -w
require "open3"

cleanFile = []
fileName = ARGV[0]
file = File.open(fileName, "r")
file.each do |line|
	next if line[/^tags/]
	next if line[/^\n/]
	line.gsub!(/^\#* ?/, "")
	line.gsub!(/^\* ?/, "")
	line.gsub!(/^\t?- ?/, "")
	line.gsub!(/\*\*/, "")
	line.gsub!(/\t*\* ?/, "")
	line.gsub!(/^\d\. ?/, "")
	line.gsub!(/^\t*\d\. ?/, "")
	cleanFile.push line
end

Open3.popen3('pbcopy') { |stdin, stdout, stderr|
	stdin.puts(cleanFile) }


