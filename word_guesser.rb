def permutation_compliments(starting_str, permutations)
  permutations = permutations.dup
  starting_str.split('').each do |x|
    permutations.delete_at permutations.index x
  end
  
  new_chars = []
  permutations.each do |x|
    new_chars << starting_str + x
  end
  new_chars
end

permutations = ARGV.first.split('')
starting_chars = []

permutations.permutation(1).each do |x|
  starting_chars << x.join
end

word_set = []

file = File.readlines("/usr/share/dict/words").map do |x|
  x.chomp.downcase
end

start = Time.now

permutations.size.times do |idx|
  idx += 1
  comparison_strings = []
  puts "starting chars are:" + starting_chars.inspect

  starting_chars.each do |x|
    comparison_strings << permutation_compliments(x, permutations)
  end

  comparison_strings.flatten!
  puts "comparison_strings are:" + comparison_strings.inspect
  exists_set = [] 

  comparison_strings.each do |x|
    file.each do |z|
      word = z
      partial = word[0..idx]
      if partial == x && word.length == permutations.size
        exists_set << x unless exists_set.include? x
        if word == x
          word_set << x
        end
      end
    end
  end
  word_set.uniq!

  puts "exists set: " + exists_set.inspect  
  starting_chars = exists_set
  puts "Word set is #{word_set}"
  puts "\n"
end

puts "Elapsed time is: " + ((Time.now - start)/60).to_s
