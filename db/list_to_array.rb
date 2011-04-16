output = File.new('array.txt', 'w')
file = File.new(ARGV[0])

array = []
re = /^<.*?>(.*)?<.*?>$/
while (line = file.gets)
	next if line.empty?
	line.chomp!
	line = re.match(line)[1] if re.match(line)
	array << '"' + line + '"'
end

output.puts '[' + array.join(", ") + ']'