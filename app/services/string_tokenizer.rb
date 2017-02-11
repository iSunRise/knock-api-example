class StringTokenizer
  class << self
    def tokenize(value)
      value.to_s.downcase.gsub(/[^\w\d]/, '')
    end
  end
end
