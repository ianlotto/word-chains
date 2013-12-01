DICTIONARY = File.readlines("dictionary.txt").map(&:chomp)

def find_chain(start_word, end_word, dictionary)
  
  raise ArgumentError.new "Both words must have the same length" if start_word.length != end_word.length
  
  current_words = [start_word]
  new_words = []
  sized_dict = dictionary.select { |d_word| start_word.size == d_word.size }

  visited_words = {start_word => nil}
  found_target = false

  #Write a check if no path is found
  while !found_target

    current_words.each do |word|

       adjacent_words(word, sized_dict).each do |adj_word|

         new_words << adj_word unless visited_words.has_key?(adj_word)
         visited_words[adj_word] = word unless visited_words.has_key?(adj_word)
       end

    end

    if new_words.include?(end_word)
      found_target = true
    else
      current_words = new_words
      new_words = []
    end

  end

  build_chain(visited_words, end_word)
end


def adjacent_words(word, dictionary)
  dictionary.select do |s_word|
    counter = 0
    word.split('').each_with_index do |letter, i|
      counter += 1 if letter != s_word[i]
    end

    counter == 1
  end
end


def build_chain(visited_words, word)
  chain = []
  vw_copy = visited_words.dup
  pred = word

  until pred.nil?
    chain.unshift(pred)
    pred = vw_copy[pred]
  end

  chain
end

begin
  p find_chain(ARGV[0], ARGV[1], DICTIONARY)
rescue ArgumentError => e
  puts "#{e.message}"
end