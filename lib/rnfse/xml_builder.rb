# -*- coding: utf-8 -*-

module Rnfse
  class XMLBuilder
    def initialize(options)
      options = Hash.stringify_keys(options)
      extend self.class.const_get(options['padrao'].capitalize)
    end
  end
end
