#!/usr/bin/ruby -w
name = ""

STDIN.each do |line|
name = line[/<\!--- ([a-zA-Z1-9]*) --->/, 1]
end

puts name
