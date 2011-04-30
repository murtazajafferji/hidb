output = File.new('array.txt', 'w')
file = File.new(ARGV[0])

array = []
#re = /^<.*?>(.*)?<.*?>$/
while (line = file.gets)
	next if line.empty?
	line.chomp!
	#if re.match(line)
	#line = re.match(line)[1] 
	array << '"' + line + '"'
  #end
end

output.puts '[' + array.join(", ") + ']'