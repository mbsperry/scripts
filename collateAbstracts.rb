#!/usr/bin/ruby -w

#	Takes the following arguments:
#	ARG1 is the input
#	ARG2 is an optional output file name. If no output is specified
#	then the script will write to stdout

#	If you want the output to be unwrapped, then just uncomment
#	2 line.chomp! commands in the script.

abstracts = []

file_name = ARGV[0]
if defined? ARGV[1]
	output_file = ARGV[1]
else
	output_file = nil
end

file = File.open(file_name, "r")
is_abstract = false

file.each do |line|
	if is_abstract == true
		if line[/^AD  -/]
			is_abstract = false
			abstracts.push "\n"
			next
		else
			line.gsub!(/^\s+/, "")
			#line.chomp!
			abstracts.push line
			next
		end
	end
	if line[/^AB  -/]
		is_abstract = true
		line.gsub!(/^AB  - /, "")
		#line.chomp!
		abstracts.push line
	end
end

if output_file != nil
	File.open(output_file, "w") {|f| f.write abstracts }
elsif output_file == nil
	puts abstracts
end

