#!/usr/bin/ruby -w


newLatex = []

preamble = <<'END'
\documentclass[11pt]{memoir}
\usepackage{fontspec}
\setmainfont[Mapping=tex-text]{Optima}
\usepackage[a4paper, landscape, margin=1in]{geometry}
\usepackage{multicol}

\renewcommand{\labelitemi}{:}
\renewcommand{\labelitemii}{::}
\renewcommand{\labelitemiii}{--}
\renewcommand{\labelitemiv}{$\cdots$}

\begin{document}

\makeevenhead{myheadings}{\thepage}{FILE_NAME}{}
\makeoddhead{myheadings}{}{FILE_NAME}{\thepage}
\makeheadrule{myheadings}{\textwidth}{\normalrulethickness}
\pagestyle{myheadings}

\begin{multicols}{2}
\firmlists
END

conclusion = <<'END'
\end{multicols}
\end{document}
END

#newLatex.push preamble

file_name = ""

STDIN.each do |line|
	if line[/\\part/]
		file_name = line[/\\part\{([^\}]+)/, 1]
		next
	end
	next if line[/\\label/]
	line.gsub!(/α/, '$\\alpha$')
	line.gsub!(/^\\chapter/, '\\section')
#	line.gsub!(/enumerate/, 'enumerate*')
#	line.gsub!(/itemize/, 'itemize*')	
	line.gsub!(/section/, 'section*')
	newLatex.push line
end

i = 0
preamble.each { |line|
	line.gsub!(/FILE_NAME/, file_name)
	newLatex.insert(i, line)
	i+=1
}

newLatex.push conclusion

File.open("/tmp/#{file_name}.tex", 'w') do |f|
	f.puts newLatex
end

puts file_name

Process.exit
