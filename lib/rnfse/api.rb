# -*- coding: utf-8 -*-

module Rnfse
  
  class API
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :api
    attr_accessor :certificate
    attr_accessor :key
    attr_accessor :xml_builder
    attr_accessor :soap_client
    attr_accessor :verbose

    def initialize(options = {})
      options = load_options(options)
            
      case
      when has_options(options, 'provedor', 'homologacao')
        provedor = provedores['homologacao'][options['provedor'].to_s]
        raise ArgumentError, 'provedor de homologação inexistente', caller if provedor.nil?
        self.api = provedor['api']
        load_options_method = :load_options_for_staging

      when has_options(options, 'provedor', 'municipio')
        provedor = provedores['producao'][options['provedor'].to_s]
        raise ArgumentError, 'provedor inexistente', caller if provedor.nil?
        self.api = provedor['api']
        load_options_method = :load_options_for_production

      when has_options(options, 'padrao', 'namespace', 'endpoint')
        self.api = options['padrao'].to_s
        load_options_method = :load_options_for_custom

      else
        raise ArgumentError, 'opções inválidas', caller
      end

      extend self.class.const_get(String.camelize(self.api))

      self.send(load_options_method, options)
    end

    private

    def load_options_for_custom(options)
      self.namespace = options['namespace'].to_s
      self.endpoint = options['endpoint'].to_s
      load_default_options(options)
    end

    def load_options_for_production(options)
      provedor = provedores['producao'][options['provedor'].to_s]
      self.namespace = provedor['namespace']
      self.endpoint = provedor['endpoint'] % { municipio: options['municipio'] }
      load_default_options(options)
    end

    def load_options_for_staging(options)
      provedor = provedores['homologacao'][options['provedor'].to_s]
      self.namespace = provedor['namespace']
      self.endpoint = provedor['endpoint']
      load_default_options(options)
    end

    def load_default_options(options)
      self.certificate = options['certificate']
      self.key = options['key']
      self.verbose = options['verbose'] || false
      self.xml_builder = options['xml_builder'] || XMLBuilder.new(padrao: self.api)
      self.soap_client = options['soap_client'] || savon_client
    end

    def provedores
      file = Pathname.new(File.expand_path('../..', __FILE__))
      YAML.load_file(file.join('provedores.yml'))
    end

    def savon_client
      savon_hash = {
        soap_version: 2,
        env_namespace: :soap,
        namespace_identifier: nil,
        ssl_verify_mode: :peer,
        ssl_cert_file: self.certificate,
        ssl_cert_key_file: self.key,
        endpoint: self.endpoint,
        namespace: self.namespace
      }

      savon_hash = savon_hash.merge(
        log: true,
        log_level: :debug,
        pretty_print_xml: true
      ) if self.verbose

      Savon.client(savon_hash)
    end

    def has_options(hash, *options)
      options.each { |option| return false if hash[option].nil? }
    end

    def load_options(hash)
      hash = Rnfse::Hash.new(hash)
      hash = hash.stringify_keys
      config = Rnfse::Configuration.instance

      attrs = ['provedor', 'municipio', 'namespace', 'endpoint',
               'verbose', 'api', 'certificate', 'key', 'xml_builder',
               'soap_client', 'verbose', 'homologacao']
      attrs.each do |attr|
        hash[attr] = config.send(attr) if hash[attr].nil?
      end
      hash
    end

  end
end
