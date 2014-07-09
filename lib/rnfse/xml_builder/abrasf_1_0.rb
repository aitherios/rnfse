# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::Abrasf10

  module ClassMethods

    def build_recepcionar_lote_rps_xml(hash = {})
      hash = prepare_hash(hash)
      inner_xml = ::Gyoku.xml(hash, key_converter: :none)
      xml_builder('EnviarLoteRpsEnvio', inner_xml).doc
    end

    private

    # prepara um hash para ser convertido a xml com o Gyoku
    def prepare_hash(hash)
      hash = camelize_hash(hash)
      hash = wrap_rps(hash)
      hash = add_tc_namespace(hash)
      hash = clean_numerics(hash)
      hash = date_to_utc(hash)
      hash = fix_booleans(hash)
      hash
    end
    
    # converte booleanos para 1 ou 2
    def fix_booleans(hash)
      regex = /(IssRetido|OptanteSimplesNacional|IncentivadorCultural|RegimeEspecialTributacao)\Z/
      Rnfse::Hash.transform_values(hash, regex) do |val|
        val ? 1 : 2
      end
    end
      
    # converte datas para GMT-0
    def date_to_utc(hash)
      Rnfse::Hash.transform_values(hash, /DataEmissao\Z/) do |val|
        DateTime.parse(val).new_offset(0).strftime('%FT%T')
      end
    end

    # limpa tags que por precaução é melhor só conter números
    def clean_numerics(hash)
      regex = /(Cep|Cnae|Cpf|Cnpj)\Z/
      Rnfse::Hash.transform_values(hash, regex) { |val| val.gsub(/\D/, '') }
    end
    
    # converte as chaves do hash para CamelCase
    def camelize_hash(hash)
      Rnfse::Hash.camelize_and_symbolize_keys(hash)
    end

    # encapsula as rps dentro de listaRps com Rps/InfRps
    def wrap_rps(hash)
      hash[:LoteRps][:ListaRps] = {
        :Rps => { :InfRps => hash[:LoteRps][:ListaRps] }
      }
      hash
    end

    # adiciona o namespace tc nas tags dentro de loteRps
    def add_tc_namespace(hash)
      hash[:LoteRps] = Rnfse::Hash.transform_keys(hash[:LoteRps]) { |key| "tc:#{key}".to_sym }
      hash
    end

    def xmlns
      'http://www.abrasf.org.br/servico_enviar_lote_rps_envio.xsd'
    end

    # namespace dos tipos complexos
    def xmlns_tc
      'http://www.abrasf.org.br/tipos_complexos.xsd'
    end  

    # instancia o builder a ser utilizado na geracao do xml
    def xml_builder(root, inner_xml)
      Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
        xml.send(root.to_sym, 'xmlns' => xmlns, 'xmlns:tc' => xmlns_tc) do
          xml << inner_xml
        end
      end
    end
  end

  extend ClassMethods

  def self.extended(base)
    base.extend(ClassMethods)
  end

  def self.included(base)
    base.include(ClassMethods)
  end

end
