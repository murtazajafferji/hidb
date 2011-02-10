output = File.new('array.txt', 'w')
file = File.new(ARGV[0])

array = []
while (line = file.gets)
	next if line.empty?
	line.chomp!
	array << '"' + line.capitalize + '"'
end

output.puts '[' + array.join(", ") + ']'