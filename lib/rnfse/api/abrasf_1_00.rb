# -*- coding: utf-8 -*-
require 'json-schema'

module Rnfse::API::Abrasf100

  module ClassMethods

    def operations
      [ :recepcionar_lote_rps, :consultar_situacao_lote_rps, 
        :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
        :cancelar_nfse ]
    end
    
    def recepcionar_lote_rps(hash = {})
      validate_sign_options
      validate_options(hash)
      xml = xml_builder.build_recepcionar_lote_rps_xml(hash) do |inner_xml|
        regex = /<tc:Rps>.*<\/tc:Rps>/
        plain_xml = inner_xml.to_xml(
          save_with: Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).strip
        signed_rps = Nokogiri::XML(
                       plain_xml.match(regex)[0]).
                     sign!(
                       certificate: File.read(self.certificate), 
                       key: File.read(self.key)).
                     to_xml(
                       save_with: Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).
                     strip
        plain_xml.gsub(regex, signed_rps)
      end
      response = self.soap_client.call(
        :recepcionar_lote_rps,
        soap_action: 'RecepcionarLoteRps',
        message_tag: 'RecepcionarLoteRps',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    def consultar_situacao_lote_rps(hash = {})
      validate_options(hash)
      xml = xml_builder.build_consultar_situacao_lote_rps_xml(hash)
      response = self.soap_client.call(
        :consultar_situacao_lote_rps,
        soap_action: 'ConsultarSituacaoLoteRps',
        message_tag: 'ConsultarSituacaoLoteRps',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    def consultar_nfse_por_rps(hash = {})
      validate_options(hash)
      xml = xml_builder.build_consultar_nfse_por_rps_xml(hash)
      response = self.soap_client.call(
        :consultar_nfse_por_rps,
        soap_action: 'ConsultarNfsePorRps',
        message_tag: 'ConsultarNfsePorRps',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    def consultar_nfse(hash = {})
      validate_options(hash)
      xml = xml_builder.build_consultar_nfse_xml(hash)
      response = self.soap_client.call(
        :consultar_nfse,
        soap_action: 'ConsultarNfse',
        message_tag: 'ConsultarNfse',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    def consultar_lote_rps(hash = {})
      validate_options(hash)
      xml = xml_builder.build_consultar_lote_rps_xml(hash)
      response = self.soap_client.call(
        :consultar_lote_rps,
        soap_action: 'ConsultarLoteRps',
        message_tag: 'ConsultarLoteRps',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    def cancelar_nfse(hash = {})
      validate_options(hash)
      xml = xml_builder.build_cancelar_nfse_xml(hash) do |inner_xml|
        inner_xml.sign!(certificate: File.read(self.certificate), key: File.read(self.key))
        inner_xml.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).strip
      end
      response = self.soap_client.call(
        :cancelar_nfse,
        soap_action: 'CancelarNfse',
        message_tag: 'CancelarNfse',
        message: { :'xml!' => "<![CDATA[#{xml}]]>" })
      parse_response(response)
    end

    private

    def validate_sign_options
      if self.certificate.nil? or self.key.nil?
        raise ArgumentError, 'opções de assinatura digital ' <<
                             '(certificate e key) ao criar ' <<
                             'o Rnfse::API faltando', caller
      end
    end

    def validate_options(hash)
      file = json_filepath("#{Rnfse::CallChain.caller_method}.json")
      json = Rnfse::Hash.camelize_and_symbolize_keys(hash, false).to_json
      errors = JSON::Validator.fully_validate(file, json)
      raise ArgumentError, errors, caller unless errors.empty?
    end

    def parse_response(response)
      hash = Rnfse::Hash.new(response.body)

      response_key = hash.keys.select { |k| k =~ /response$/ }
      response_key = response_key.first unless response_key.nil?

      if hash[response_key]
        result_key = hash[response_key].keys.select { |k| k =~ /result$/ }
        result_key = result_key.first unless result_key.nil?
      else
        result_key = nil
      end

      if response_key and result_key
        xml = hash[response_key][result_key]
        hash[response_key][result_key] = Nori.new.parse(xml)
      end
      hash.underscore_and_symbolize_keys
    end

    def json_folder
      'abrasf_1_00'
    end

    def json_filepath(filename)
      result = nil
      folders = ['abrasf_1_00']
      folders = folders.unshift(json_folder) unless folders.include?(json_folder)
      folders.each do |folder|
        path = File.join(File.expand_path(File.dirname(__FILE__)), folder, filename)
        result = path if File.exists?(path)
      end
      result
    end

  end

  extend ClassMethods

  def self.extended(base)
    base.extend(ClassMethods)
  end

  def self.included(base)
    base.send(:include, ClassMethods)
  end

end
