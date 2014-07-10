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
      else
        raise ArgumentError, errors, caller
      end
    end

    private

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
