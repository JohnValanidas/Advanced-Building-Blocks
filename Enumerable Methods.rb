# You learned about the Enumerable module that gets mixed in to the Array
# and Hash classes (among others) and provides you with lots of handy iterator methods.
# To prove that there's no magic to it, you're going to rebuild those methods.

module Enumerable
  def my_each
    return self.to_enum if !block_given? #no block requires to return an enum
    index = 0
    while index < self.size
      yield(self[index])
      index += 1
    end
  end


  def my_each_with_index
    index = 0
    while index < self.size
      yield(self[index], index) #this time two elements are passed to the block.
      index += 1
    end
  end


  def my_select
    index = 0
    select_array = []
    while index < self.size
      if yield(self[index]) == true
        select_array.push(self[index])
      end
      index += 1
    end
    select_array
  end

  def my_all?
    index = 0
    state = true
    while index < self.size
      if yield(self[index]) == true
        index += 1
      else
        state = false
        break
      end
    end
    state
  end

  def my_any?
    index = 0;
    state = false
    while index < self.size
      if yield(self[index]) == true
        state = true
        break
      else
        index += 1
      end
    end
    state
  end

  def my_none?
    index = 0
    none = true
    while index < self.size
      if yield(self[index]) == true
        none = false
        break
      else
        index += 1
      end
    end
    none
  end

  def my_count
    index = 0
    count = 0
    if block_given?
      while index < self.size
        if yield(self[index]) == true
          count += 1
        end
        index += 1
      end
    else
      while index < self.size
        count = index + 1 #the plus one is because index starts at 1
        index += 1
      end
    end
    count
  end

#Returns a new array with the results of running block once for every element in enum.
#If no block is given, an enumerator is returned instead.
  def my_map (&proc)
    return self.to_enum if !block_given?
    index = 0
    array = []
    while index < self.size
      if block_given?
        array.push(yield(self[index]))
      else # modified to accept procs but prioritizes blocks
        array.push proc.call(index)
      end
      index += 1
    end
    array
  end

#Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.
#The inject and reduce methods are aliases. There is no performance benefit to either.
#If you specify a block, then for each element in enum the block is passed an accumulator
# value (memo) and the element. If you specify a symbol instead, then each element in the
#collection will be passed to the named method of memo. In either case, the result becomes
#the new value for memo. At the end of the iteration, the final value of memo is the return value for the method.
#If you do not explicitly specify an initial value for memo, then the first element of collection is used as the initial value of memo.

  def my_inject (initial =0, sym)
    if initial != 0
      index = 0
      object = initial
    else
      index = 1
      object =self[initial]
    end
    if block_given?
      while index < self.size
        object  = yield(object, index)
        index += 1
      end
    else
      while index < self.size
        object = object.send(sym, self[index])
        index += 1
      end
    end
    object
  end


end


def multiply_els array
  array.my_inject(:*)
end

#testing
array = [1,4,2,5,6]
puts ".my_each"
array.my_each {|element| print element}
puts ".each:"
array.each { |element| print element}
puts ".my_select:"
puts array.my_select {|element| element%2 == 0}
puts ".select:"
puts array.select {|element| element%2 == 0}
puts ".my_all?:"
puts array.my_all? {|element| element > 10 }
puts ".all?:"
puts array.all? {|element| element > 10 }
puts ".my_any?:"
puts array.my_any? {|element| element == 3}
puts ".any?"
puts array.any? {|element| element == 3}
puts ".my_count:"
puts array.my_count
puts ".count:"
puts array.count
puts "my_map:"
puts array.my_map {|element| element * 2}
puts ".map:"
puts array.map {|element| element * 2}
puts ".my_inject:"
puts array.my_inject(2,:*)
puts "inject:"
puts array.inject(2,:*)
puts "multiply_els([2,4,5]) #=> 40:"
puts multiply_els([2,4,5])
