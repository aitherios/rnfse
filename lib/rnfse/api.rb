# -*- coding: utf-8 -*-
require 'yaml'
require 'pathname'

module Rnfse
  class API
    
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :api
    
    def initialize(options)
      options = options.inject({}) { |hash,(x,y)| hash[x.to_s] = y.to_s; hash }
      file = Pathname.new(File.expand_path('../..', __FILE__))
      provedores = YAML.load_file(file.join('provedores.yml'))
        
      case
      when has_options(options, 'provedor', 'homologacao')
        provedor = provedores['homologacao'][options['provedor']]
        raise ArgumentError, 'provedor de homologação inexistente', caller if provedor.nil?
        self.namespace, self.endpoint = [provedor['namespace'], provedor['endpoint']]
        self.api = provedor['api']

      when has_options(options, 'provedor', 'municipio')
        provedor = provedores['producao'][options['provedor']]
        raise ArgumentError, 'provedor inexistente', caller if provedor.nil?
        self.namespace = provedor['namespace']
        self.endpoint = provedor['endpoint'] % { municipio: options['municipio'] }
        self.api = provedor['api']

      when has_options(options, 'padrao', 'namespace', 'endpoint')
        self.namespace, self.endpoint = [options['namespace'], options['endpoint']]
        self.api = options['padrao']

      else
        raise ArgumentError, 'opções inválidas', caller
      end

      extend self.class.const_get(self.api.capitalize)
    end

    private

    def has_options(hash, *options)
      options.each { |option| return false if hash[option].nil? }
    end

  end
end