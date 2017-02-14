def bubble_sort array
  sort_count = 0
  while 0 < array.length - sort_count - 1
    index = 0;
    while index < (array.length - 1 - sort_count)
      if array[index] > array[index+1]
        array[index], array[index+1] = array[index+1], array[index]
      end
      index += 1
    end
    sort_count += 1
  end
  array
end

def bubble_sort_by(array)
  sort_count = 0
  while 0 < array.length - sort_count
    index = 0
    while index < (array.length - 1 - sort_count)
      value = yield(array[index], array[index+1] )
      if value > 0
        array[index], array[index+1] = array[index+1], array[index]
      end
      index +=1
    end
    sort_count += 1
  end
  array
end

array = [4,3,78,2,0,2]
word_array =  ["hi","hello","hey"]

puts bubble_sort([4,3,78,2,0,2])

puts bubble_sort_by(word_array) { |left, right| left.length - right.length }
