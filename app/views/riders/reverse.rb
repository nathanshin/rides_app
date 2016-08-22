def reverse(string)
	length = string.length
	string.each_char.with_index do |char, i|
		string[i] = string[length - i]
		string[length - i] = char
	end

	puts string
end

reverse("hello")