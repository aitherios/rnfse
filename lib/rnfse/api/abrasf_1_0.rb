# -*- coding: utf-8 -*-
require 'json-schema'

module Rnfse::API::Abrasf10

  module ClassMethods

    def recepcionar_lote_rps(hash = {})
      file = get_filepath('recepcionar_lote_rps.json')
      json = Rnfse::Hash.camelize_and_symbolize_keys(hash, false).to_json
      errors = JSON::Validator.fully_validate(file, json)
      if errors.empty?
        xml = xml_builder.build_recepcionar_lote_rps_xml(hash)
        xml.sign!(certificate: File.read(self.certificate), key: File.read(self.key))
        response = self.soap_client.call(
          :recepcionar_lote_rps,
          soap_action: 'RecepcionarLoteRps',
          message_tag: 'RecepcionarLoteRps',
          message: { :'xml!' => "<![CDATA[#{xml}]]>" })
        parse_response(response)
      else
        raise ArgumentError, errors, caller
      end
    end

    private

    def parse_response(response)
      hash = Rnfse::Hash.new(response.body)
      lote_rps_response = hash[:recepcionar_lote_rps_response]
      if !lote_rps_response.empty? and lote_rps_response[:recepcionar_lote_rps_result]
        xml = hash[:recepcionar_lote_rps_response][:recepcionar_lote_rps_result]
        hash[:recepcionar_lote_rps_response][:recepcionar_lote_rps_result] =
          Nori.new.parse(xml)
      end
      hash.underscore_and_symbolize_keys
    end

    def get_filepath(filename)
      File.join(File.expand_path(File.dirname(__FILE__)), 'abrasf_1_0', filename)
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
