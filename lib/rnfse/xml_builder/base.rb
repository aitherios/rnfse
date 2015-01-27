# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::Base

  private

  # Constroi xml encapsulado pela soap action usando o +data+ hash.
  # Customizações podem ser utilizadas via +options+ hash, 
  # caso contrário serão inferidas pelo nome do método que invocou.
  # 
  # ==== Options
  # 
  # * <tt>:action<tt> - Define nome da soap action.
  #   Caso não informado infere chamando <tt>get_action_from<tt>
  # * <tt>:namespace<tt> - Define namespaces no xml encapsulado pela soap action.
  #   Caso não informado infere chamando <tt>get_namespace_from<tt>
  def build_xml(data, options = {})
    caller = Rnfse::CallChain.caller_method
    options = Rnfse::Hash.new(options).stringify_keys
    data = alter_data_before_builder(Rnfse::Hash.new(data).stringify_keys)

    namespace = options['namespace'] || get_namespace_from(caller)
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

  # Infere o nome da soap action.
  # Tenta primeiro usando o valor de +operation_options+,
  # caso contrário infere somente de +caller+.
  #
  # ==== Examples
  # 
  #   get_action_from(:build_recepcionar_lote_rps_xml)
  #   # => 'RecepcionarLoteRpsEnvio'
  #
  #   operations_options = { 
  #     recepcionar_lote_rps: { action: 'EnviarLoteRpsEnvio' } 
  #   }
  #   get_action_from(:build_recepcionar_lote_rps_xml, operation_options)
  #   # => 'EnviarLoteRpsEnvio'
  def get_action_from(caller, operation_options = {})
    operation = get_operation_from(caller)
    if operation_options and 
       operation_options[operation] and 
       operation_options[operation][:action]

      operation_options[operation][:action]
    else
      "#{Rnfse::String.new(operation.to_s).camelize}Envio"
    end
  end


  # Infere o nome da operação.
  #
  # ==== Example
  #
  #   get_action_from(:build_recepcionar_lote_rps_xml)
  #   # => 'recepcionar_lote_rps'
  def get_operation_from(caller)
    caller.to_s.gsub(/(^build_|_xml$)/, '').to_sym
  end

  # Infere o namespace a ser utilizado na soap action.
  # Tenta primeiro usando o valor de +operation_options+,
  # caso contrário usa o valor default.
  # 
  # ==== Examples
  # 
  #   get_namespace_from(:build_recepcionar_lote_rps_xml)
  #   # => { xmlns: 'http://www.abrasf.org.br/nfse.xsd' }
  # 
  #   operation_options = {
  #     all: {
  #       namespace: { xmlns_tc: 'http://www.abrasf.org.br/tc.xsd' }
  #     },
  #     recepcionar_lote_rps: {
  #       namespace: { xmlns_ts: 'http://www.abrasf.org.br/ts.xsd' }
  #     }
  #   }
  #   get_namespace_from(:build_recepcionar_lote_rps_xml, operation_options)
  #   # => { xmlns_tc: 'http://www.abrasf.org.br/tc.xsd',
  #          xmlns_ts: 'http://www.abrasf.org.br/ts.xsd' }
  #
  def get_namespace_from(caller, operation_options = {})
    operation = get_operation_from(caller)
    namespace = {}
    if operation_options[:all] and operation_options[:all][:namespace]
      namespace.merge!(operation_options[:all][:namespace])
    end
    if operation_options[operation] and operation_options[operation][:namespace]
      namespace.merge!(operation_options[operation][:namespace])
    end
    if operation_options.empty?
      namespace = { xmlns: 'http://www.abrasf.org.br/nfse.xsd' }
    end
    namespace
  end

  # Altera o valor de +data+ utilizado no build_xml.
  # Por padrão não altera nada.
  def alter_data_before_builder(data)
    data
  end

  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods

    # Injeta um xml_builder para cada item de +operations+.
    # É customizado por +operation_options+.
    #
    # ==== Example
    #
    #   inject_builder_methods([:recepcionar_lote_rps])
    #   chama o método: inject_builder_method(:build_recepcionar_lote_rps_xml)
    def inject_builder_methods(operations, operation_options = {})
      operations.each do |operation|
        self.inject_builder_method("build_#{operation}_xml".to_sym, operation_options)
      end
    end

    # Injeta um xml_builder com base em +method+.
    def inject_builder_method(method, operation_options)
      define_method(method) do |hash = {}|
        options = {
          action: get_action_from(__callee__, operation_options),
          namespace: get_namespace_from(__callee__, operation_options)
        }
        if block_given?
          build_xml(hash, options, &Proc.new)
        else
          build_xml(hash, options)
        end
      end
    end

    def included(base)
      base.extend ClassMethods
    end
  end

end
