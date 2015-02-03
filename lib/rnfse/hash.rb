# -*- coding: utf-8 -*-

module Rnfse
  class Hash < ::Hash

    def initialize(constructor = {})
      if constructor.is_a?(::Hash)
        super
        update(constructor)
      else
        super(constructor)
      end
    end

    def update(other_hash)
      if other_hash.is_a?(Hash)
        super(other_hash)
      else
        other_hash.to_hash.each_pair do |key, value|
          self[key] = value
        end
      end
    end

    def self.stringify_keys(obj)
      self.transform_keys(obj) { |key| key.to_s rescue key }
    end
    
    def stringify_keys
      self.class.stringify_keys(self)
    end

    def self.symbolize_keys(obj)
      self.transform_keys(obj) { |key| key.to_sym rescue key }
    end
    
    def symbolize_keys
      self.class.symbolize_keys(self)
    end

    def symbolize_keys!
      self.replace(self.symbolize_keys)
    end

    def self.camelize_keys(obj, uppercase_first_letter = true)
      self.transform_keys(obj) do |key|
        begin
          str = String.camelize(key.to_s, uppercase_first_letter)
          key.kind_of?(::Symbol) ? str.to_sym : str
        rescue key
        end
      end
    end

    def camelize_keys(uppercase_first_letter = true)
      self.class.camelize_keys(self, uppercase_first_letter)
    end

    def camelize_keys!(uppercase_first_letter = true)
      self.replace(self.camelize_keys(uppercase_first_letter))
    end

    def self.camelize_and_symbolize_keys(obj, uppercase_first_letter = true)
      self.transform_keys(obj) do |key|
        String.camelize(key.to_s, uppercase_first_letter).to_sym rescue key
      end
    end

    def camelize_and_symbolize_keys(uppercase_first_letter = true)
      self.class.camelize_and_symbolize_keys(self, uppercase_first_letter)
    end

    def self.gsub_keys(obj, pattern, replacement)
      self.transform_keys(obj) do |key|
        begin
          str = key.to_s.gsub(pattern, replacement)
          key.kind_of?(::Symbol) ? str.to_sym : str
        rescue key
        end
      end
    end

    def gsub_keys(pattern, replacement)
      self.class.gsub_keys(self, pattern, replacement)
    end

    def gsub_keys!(pattern, replacement)
      self.replace(self.gsub_keys(pattern, replacement))
    end

    def self.underscore_and_symbolize_keys(obj)
      self.transform_keys(obj) do |key|
        String.underscore(key.to_s).to_sym rescue key
      end
    end

    def underscore_and_symbolize_keys
      self.class.underscore_and_symbolize_keys(self)
    end
    
    def self.transform_keys(obj, regex = nil, &block)
      regex = /.*/ if regex.nil?

      case
      when obj.kind_of?(::Hash)
        result = {}
        obj.each_key do |key|
          if regex.match(key)
            result[yield(key)] = self.transform_keys(obj[key], regex, &block)
          else
            result[key] = self.transform_keys(obj[key], regex, &block)
          end
        end
        result
      when obj.kind_of?(::Array)
        result = []
        obj.each do |elem|
          result << self.transform_keys(elem, regex, &block)
        end
        result
      else
        obj
      end
    end

    def transform_keys(regex = nil, &block)
      self.class.transform_keys(self, regex, &block)
    end

    def self.transform_values(obj, key, &block)
      key = /\A#{key}\Z/ unless key.kind_of?(::Regexp)

      case
      when obj.kind_of?(::Hash)
        result = {}
        obj.each_key do |k|
          if key.match(k)
            result[k] = yield(obj[k])
          else
            result[k] = self.transform_values(obj[k], key, &block)
          end
        end
        result
      when obj.kind_of?(::Array)
        result = []
        obj.each do |elem|
          result << self.transform_values(elem, key, &block)
        end
        result
      else
        obj
      end
    end

    def transform_values(key, &block)
      self.class.transform_values(self, key, &block)
    end

    def self.replace_key_values(obj, key, &block)
      parent, children = case
                         when key.kind_of?(::Regexp)
                           [ key, [] ]
                         when key.kind_of?(::Array)
                           [ key.first, key[1..-1] ]
                         else
                           parts = key.to_s.split('/')
                           [ parts.first, parts[1..-1] ]
                         end
      regex = parent.kind_of?(::Regexp) ? parent : /\A#{parent}\Z/

      case
      when obj.kind_of?(::Hash)
        result = {}
        obj.each_key do |k|
          case
          when (regex.match(k) and children.empty?)
            result.merge!(yield(k, obj[k]))
          when (regex.match(k) and !children.empty?)
            result[k] = self.replace_key_values(obj[k], children, &block)
          else
            result[k] = self.replace_key_values(obj[k], key, &block)
          end
        end
        result
      when obj.kind_of?(::Array)
        result = []
        obj.each do |elem|
          result << self.replace_key_values(elem, key, &block)
        end
        result
      else
        obj
      end
    end

    def replace_key_values(key, &block)
      self.class.replace_key_values(self, key, &block)
    end

  end
end
