class Array 
	# wraps the items in the array in a 
	# pre and post string, like ['foo','bar','baz'].sandwich('<td>','</td>')
	# => "<td>foo</td><td>bar</td><td>baz</td>"
	def sandwich(str1, str2)
		map{|item| "#{str1}#{item}#{str2}"}.join("")
	end
end