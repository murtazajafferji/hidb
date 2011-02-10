output = File.new('array.txt', 'w')
file = File.new("to_be_compressed.txt")

array = []
while (line = file.gets)
	next if line.empty?
	line = line.chomp.lstrip.rstrip
	array << line
end

output.puts '[' + array.join(" ") + ']'