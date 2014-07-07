# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::Abrasf_1_0

  def build_recepcionar_lote_rps_xml(hash = {})
    # todas as tags devem estar em CamelCase
    hash = Rnfse::Hash.camelize_and_symbolize_keys(hash)

    # coteúdo de listaRps são tags Rps/InfRps
    hash[:LoteRps][:ListaRps] = { :Rps => { :InfRps => hash[:LoteRps][:ListaRps] } }

    # o namespace de todas as tags dentro de loteRps é tc
    hash[:LoteRps] = Rnfse::Hash.transform_keys(hash[:LoteRps]) { |key| "tc:#{key}".to_sym }

    # limpando tags que por precaução é melhor só conter números
    regex = /(Cep|Cnae|Cpf|Cnpj)\Z/
    hash = Rnfse::Hash.transform_values(hash, regex) { |val| val.gsub(/\D/, '') }

    # convertendo a data para GMT-0
    hash = Rnfse::Hash.transform_values(hash, /DataEmissao\Z/) do |val|
      DateTime.parse(val).new_offset(0).strftime('%FT%T')
    end

    # substituindo booleanos por 1 ou 2
    regex = /(IssRetido|OptanteSimplesNacional|IncentivadorCultural)\Z/
    hash = Rnfse::Hash.transform_values(hash, regex) do |val|
      val ? 1 : 2
    end

    inner_xml = ::Gyoku.xml(hash, key_converter: :none)
    xml_builder('EnviarLoteRpsEnvio', inner_xml).doc
  end

  private

  def xmlns
    'http://www.abrasf.org.br/servico_enviar_lote_rps_envio.xsd'
  end

  def xmlns_tc
    'http://www.abrasf.org.br/tipos_complexos.xsd'
  end  

  def xml_builder(root, inner_xml)
    Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
      xml.send(root.to_sym, 'xmlns' => xmlns, 'xmlns:tc' => xmlns_tc) do
        xml << inner_xml
      end
    end
  end

end
