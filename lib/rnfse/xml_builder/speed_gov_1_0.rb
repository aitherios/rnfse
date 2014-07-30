# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::SpeedGov10
  include Rnfse::XMLBuilder::Abrasf10

  def build_header_xml
    Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.cabecalho('versao' => '1',
                    'xmlns:p' => 'http://ws.speedgov.com.br/cabecalho_v1.xsd',
                    'xmlns:ds' => 'http://www.w3.org/2000/09/xmldsig#',
                    'xmlns:p1' => 'http://ws.speedgov.com.br/tipos_v1.xsd',
                    'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                    'xsi:schemaLocation' => 'http://ws.speedgov.com.br/cabecalho_v1.xsd') do
        xml.versaoDados('1')
        xml.parent.namespace = xml.parent.namespace_definitions.first
      end
    end.doc
  end

  def build_consultar_nfse_envio_xml(hash = {})
    hash = prepare_hash(hash)
    inner_xml = ::Gyoku.xml(hash, key_converter: :none)
    Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.send('p:ConsultarNfseEnvio'.to_sym, build_parameters_xmlns) do
        xml << inner_xml
      end
    end.doc
  end

  def build_parameters_xmlns
    {
      'xmlns:ds' => "http://www.w3.org/2000/09/xmldsig#",
      'xmlns:p' => "http://ws.speedgov.com.br/consultar_nfse_envio_v1.xsd",
      'xmlns:p1' => "http://ws.speedgov.com.br/tipos_v1.xsd",
      'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
      'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_nfse_envio_v1.xsd"
    }
  end

  private

  def prepare_hash(hash)
    hash = camelize_hash(hash)
    hash = clean_numerics(hash)
    hash = add_p_namespace(hash)
    hash = add_p1_namespace(hash)
    hash
  end

  def add_p_namespace(hash)
    Rnfse::Hash.transform_keys(hash) { |key| "p:#{key}".to_sym }
  end

  def add_p1_namespace(hash)
    regex = /(Cpf|Cnpj|InscricaoMunicipal)\Z/
    Rnfse::Hash.transform_keys(hash, regex) do |key|
      "p1:#{key.to_s.gsub(/^[^:]+:/, '')}"
    end
  end

end
