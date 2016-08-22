def sort(arr)
	(1..arr.length).each_with_index do |number, i|
		key = arr[i]
		
		j = i - 1
		while j > 0 && arr[j] > key
			arr[j + 1] = arr[j]
			j -= 1
		end
		arr[j + 1] = key 
	end
end

