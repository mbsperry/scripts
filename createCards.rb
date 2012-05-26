#!/usr/bin/ruby -w
# This script takes a file of questions 
# And outputs text suitable to import into Anki
# Requires the question filename as input
# Returns output to to STDOUT

raise "No filename supplied" if ARGV[0] == nil 
fileName = ARGV[0]
file = File.open(fileName, "r") 
factText = ""
factArray = []
clozeExp = Regexp.new(/\[([^\]]*)\]/)
hasEND = true

file.each do |line|
  line.gsub!(/\*\*([^\*]*)\*\*/, '<strong>\1</strong>')
  if line["tags:"] then
    factArray.push line
  elsif line[clozeExp] then
		#first let's do some syntax checking. Make sure all statements are closed.
    raise 'Expected "/:", found: ' + '"' + line + '"'  if hasEND == false 
		raise 'Expected "]", found: ' + '"' + line + '"' if line[/\[[^\]]*\[/]
		question = []
		matches = []
		#create the answer line
		answer = line.gsub(clozeExp, '<strong>\1</strong>') 				
		cleanLine = line.gsub(clozeExp, '\1')
		#make array of all [cloze] statements 
		line.gsub(clozeExp) {|match| matches.push match}						
		#for each match, delete the []'s and generate the appropriate question.
		matches.each {|match|
			match.gsub!(clozeExp, '\1')
			question.push cleanLine.gsub(match, "<strong>[...]</strong>")	
		}																														
		question.each {|q| factArray.push q.chomp + ";" + answer}
  elsif line[/^:/] then 
    raise "Expected [/:], found: " + line  if hasEND == false 
    factText = line.gsub(/^:/, "").chomp + ";"
    hasEND = false  # Set to false because we are mid block
  elsif line[/ \/:/] then
    factText = factText + line.gsub(/ \/:/, "")
    factArray.push factText
    hasEND = true  # end statement found!
  else
    factText = factText + line.chomp + "<br>"	
  end
end
puts factArray
Process.exit
