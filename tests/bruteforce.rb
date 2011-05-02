alphabet = [('a'..'z').to_a, ('A'..'Z').to_a, ('0'..'9').to_a].flatten
def r (str, depth, alphabet, &block)
  depth == 0 ? yield(str) : (0..(alphabet.length-1)).each {|i| r(str + alphabet[i], depth-1, alphabet, &block) }
end
r("", 10, alphabet) { |str| print "Password: " + str + "\n"}
