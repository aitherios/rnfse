# -*- coding: utf-8 -*-

module Rnfse
  class API
    
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :api
    
    def initialize(options)
      options = Hash.stringify_keys(options)
      
      file = Pathname.new(File.expand_path('../..', __FILE__))
      provedores = YAML.load_file(file.join('provedores.yml'))
      
      case
      when has_options(options, 'provedor', 'homologacao')
        provedor = provedores['homologacao'][options['provedor'].to_s]
        raise ArgumentError, 'provedor de homologação inexistente', caller if provedor.nil?
        self.namespace = provedor['namespace']
        self.endpoint = provedor['endpoint']
        self.api = provedor['api']

      when has_options(options, 'provedor', 'municipio')
        provedor = provedores['producao'][options['provedor'].to_s]
        raise ArgumentError, 'provedor inexistente', caller if provedor.nil?
        self.namespace = provedor['namespace']
        self.endpoint = provedor['endpoint'] % { municipio: options['municipio'] }
        self.api = provedor['api']

      when has_options(options, 'padrao', 'namespace', 'endpoint')
        self.namespace = options['namespace'].to_s
        self.endpoint = options['endpoint'].to_s
        self.api = options['padrao'].to_s

      else
        raise ArgumentError, 'opções inválidas', caller
      end

      extend self.class.const_get(String.camelize(self.api))
    end

    private

    def has_options(hash, *options)
      options.each { |option| return false if hash[option].nil? }
    end

  end
end
