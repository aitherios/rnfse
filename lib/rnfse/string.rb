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
      self.new(string)
    end

    def camelize
      self.class.camelize(self) 
    end

    def self.underscore(term)
      word = term.to_s.gsub('::', '/')
      word.gsub!(/(?:([A-Za-z\d])|^)(?=\b|[^a-z])/)
      #{ "#{$1}#{$1 && '_'}#{$2.downcase}" }
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      self.new(word)
    end

    def underscore
      self.class.underscore(self)
    end

    def self.demodulize(path)
      path = path.to_s
      self.new( if i = path.rindex('::')
                  path[(i+2)..-1]
                else
                  path
                end )
    end
    
    def demodulize
      self.class.demodulize(self)
    end

  end
end
