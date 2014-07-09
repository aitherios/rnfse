# -*- coding: utf-8 -*-

module Rnfse
  class Hash < ::Hash

    def self.stringify_keys(obj)
      self.transform_keys(obj) { |key| key.to_s rescue key }
    end

    def self.symbolize_keys(obj)
      self.transform_keys(obj) { |key| key.to_sym rescue key }
    end

    def self.camelize_and_symbolize_keys(obj, uppercase_first_letter = true)
      self.transform_keys(obj) do |key|
        String.camelize(key.to_s, uppercase_first_letter).to_sym rescue key
      end
    end
    
    def self.transform_keys(obj, &block)
      case
      when obj.kind_of?(::Hash)
        result = {}
        obj.each_key do |key|
          result[yield(key)] = self.transform_keys(obj[key], &block)
        end
        result
      when obj.kind_of?(::Array)
        result = []
        obj.each do |elem|
          result << self.transform_keys(elem, &block)
        end
        result
      else
        obj
      end
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

    def self.replace_key_values(obj, key, &block)
      parent = key.to_s.split('/').first
      childs = key.to_s.split('/')[1..-1]
      regex = key.kind_of?(::Regexp) ? key : /\A#{parent}\Z/

      case
      when obj.kind_of?(::Hash)
        result = {}
        obj.each_key do |k|
          case
          when (regex.match(k) and childs.empty?)
            result.merge!(yield(k, obj[k]))
          when (regex.match(k) and !childs.empty?)
            result[k] = self.replace_key_values(obj[k], childs.join('/'), &block)            
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

  end
end
