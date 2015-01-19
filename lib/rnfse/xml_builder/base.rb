# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::Base

  module ClassMethods

    private

    # Constroi xml encapsulado pela soap action usando o +data+ hash.
    # Customizações podem ser utilizadas via +options+ hash, 
    # caso contrário serão inferidas pelo nome do método que invocou.
    # 
    # ==== Options
    # 
    # * <tt>:action<tt> - Define nome da soap action
    # * <tt>:namespace<tt> - Define namespaces no xml encapsulado pela soap action
    #
    # ==== Examples
    # 
    #   def build_recepcionar_lote_rps_xml
    #     build_xml()
    #   end
    #   
    # * <tt>:action<tt> - build_recepcionar_lote_rps_xml vira RecepcionarLoteRpsEnvio
    # * <tt>:namespace<tt> - chama o método recepcionar_lote_rps_xml_namespace
    def build_xml(data, options = {})
      caller = Rnfse::CallChain.caller_method
      options = Rnfse::Hash.new(options).stringify_keys
      data = Rnfse::Hash.new(data).stringify_keys

      namespace = options['namespace'] || self.send(get_namespace_method_from(caller))
      action = options['action'] || get_action_from(caller)

      inner_xml = if block_given? 
                    yield(data)
                  else
                    ::Gyoku.xml(data, key_converter: :none)
                  end

      Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
        xml.send(action, namespace) do
          xml << inner_xml
        end
      end.doc
    end
    
    def get_action_from(caller)
      "#{Rnfse::String.new(caller.to_s.gsub(/(^build_|_xml$)/, '')).camelize}Envio"      
    end

    def get_namespace_method_from(caller)
      "#{caller.to_s.gsub(/^build_/, '')}_namespace"
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
