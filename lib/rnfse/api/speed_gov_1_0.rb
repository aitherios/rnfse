# -*- coding: utf-8 -*-

module Rnfse::API::SpeedGov10
  include Rnfse::API::Abrasf10

  def recepcionar_lote_rps()
    raise Rnfse::Error::NotImplemented
  end

  def consultar_situacao_lote_rps()
    raise Rnfse::Error::NotImplemented
  end

  def consultar_lote_rps()
    raise Rnfse::Error::NotImplemented
  end

  private
  
  def load_options_for_production(options)
    provedor = provedores['producao'][options['provedor'].to_s]
    self.namespace = provedor['namespace']
    municipio = case options['municipio'].to_s
                when 'petrolina' then 'pet'
                when 'aquiraz' then 'aqz'
                else options['municipio'].to_s
                end
    self.endpoint = provedor['endpoint'] % { municipio: municipio }
    load_default_options(options)
  end

end
