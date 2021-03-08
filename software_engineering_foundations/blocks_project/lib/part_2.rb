def all_words_capitalized?(arr)
    arr.all? {|word| word == word.downcase.capitalize}
end

def no_valid_url?(urls)
    no = [".com", ".net", ".io", ".org"]
    urls.none? do |url|
        no.any? do |n| 
            has = url.scan(n).length
            has > 0
        end
    end
end

def any_passing_students?(arr_hash)
    arr_hash.any? {|k| (k[:grades].sum(0.0) / k[:grades].length) >= 75}
end