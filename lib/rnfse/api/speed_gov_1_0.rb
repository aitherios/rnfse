# -*- coding: utf-8 -*-

module Rnfse::API::SpeedGov10
  include Rnfse::API::Abrasf10

  def recepcionar_lote_rps(hash = {})
    validate_sign_options
    validate_options(hash)
    header = xml_builder.build_header_xml()
    parameters = xml_builder.build_recepcionar_lote_rps_xml(hash)
    response = self.soap_client.call(
      :recepcionar_lote_rps,
      soap_action: 'RecepcionarLoteRps',
      message_tag: 'nfse:RecepcionarLoteRps',
      message: { :'header!' => "<![CDATA[#{header}]]>",
                 :'parameters!' => "<![CDATA[#{parameters}]]>" })
    parse_response(response)
  end

  def consultar_situacao_lote_rps(hash = {})
    raise Rnfse::Error::NotImplemented
  end

  def consultar_lote_rps(hash = {})
    raise Rnfse::Error::NotImplemented
  end

  def consultar_nfse_por_rps(hash = {})
    validate_options(hash)
    header = xml_builder.build_header_xml()
    parameters = xml_builder.build_consultar_nfse_rps_envio_xml(hash)
    response = self.soap_client.call(
      :consultar_nfse_por_rps,
      soap_action: 'ConsultarNfsePorRps',
      message_tag: 'nfse:ConsultarNfsePorRps',
      message: { :'header!' => "<![CDATA[#{header}]]>",
                 :'parameters!' => "<![CDATA[#{parameters}]]>" })
    parse_response(response)
  end

  def consultar_nfse(hash = {})
    validate_options(hash)
    header = xml_builder.build_header_xml()
    parameters = xml_builder.build_consultar_nfse_envio_xml(hash)
    response = self.soap_client.call(
      :consultar_situacao_lote_rps,
      soap_action: 'ConsultarNfse',
      message_tag: 'nfse:ConsultarNfse',
      message: { :'header!' => "<![CDATA[#{header}]]>",
                 :'parameters!' => "<![CDATA[#{parameters}]]>" })
    parse_response(response)
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

  def parse_response(response)
    hash = Rnfse::Hash.new(response.body)
    response_key = hash.keys.select { |k| k =~ /response$/ }.first
    return_key = hash[response_key].keys.select { |k| k =~ /return$/ }.first
    if !hash[response_key].nil? and hash[response_key]
      xml = hash[response_key][return_key]
      hash[response_key][return_key] = Nori.new.parse(xml)
    end
    hash.underscore_and_symbolize_keys
  end

  def savon_client_options
    {
      soap_version: 1,
      env_namespace: :soapenv,
      namespaces: { 'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
                    'xmlns:nfse' => 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd',
                    'xmlns' => '' },
      namespace_identifier: nil,
      ssl_verify_mode: :peer,
      ssl_cert_file: self.certificate,
      ssl_cert_key_file: self.key,
      endpoint: self.endpoint,
      namespace: self.namespace
    }
  end

  def json_folder
    'speed_gov_1_0'
  end

end
