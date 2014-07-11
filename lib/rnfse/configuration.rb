module Rnfse
  class Configuration
    include Singleton
    
    attr_accessor :provedor
    attr_accessor :municipio
    attr_accessor :namespace
    attr_accessor :endpoint
    attr_accessor :homologacao
    attr_accessor :api
    attr_accessor :certificate
    attr_accessor :key
    attr_accessor :xml_builder
    attr_accessor :soap_client
    attr_accessor :verbose

  end
end
