# -*- coding: utf-8 -*-

module Rnfse
  class String < ::String
    def self.camelize(term, uppercase_first_letter = true)
      string = term.to_s
      if uppercase_first_letter
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
      else
        string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
      end
      string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize }
      string.gsub!('/', '::')
      string
    end
  end
end
