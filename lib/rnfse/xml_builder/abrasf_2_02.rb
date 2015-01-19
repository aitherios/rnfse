# -*- coding: utf-8 -*-

# Construtor dos xmls encapsulados pelas soap actions previstas 
# no padrão Abrasf 2.02.
# Inclui um método público para cada soap action.
#
# ==== Soap Actions
#
# * RecepcionarLoteRps 
# * RecepcionarLoteRpsSincrono
# * GerarNfse
# * CancelarNfse
# * SubstituirNfse
# * ConsultarLoteRps
# * ConsultarNfsePorRps
# * ConsultarNfseServicoPrestado
# * ConsultarNfseServicoTomado
# * ConsultarNfseFaixa
#
#   Os métodos públicos são baseados no nome da sopa action 
#   em snake_case.
#   E.g. RecepcionarLoteRps vira build_recepcionar_lote_rps_xml
#
#   Para mais detalhes sobre cada soap action veja a seção de
#   documentação do README.md
module Rnfse::XMLBuilder::Abrasf202
  include Rnfse::XMLBuilder::Base

  module ClassMethods
    def self.operations
      [
       :recepcionar_lote_rps, :recepcionar_lote_rps_sincrono, :gerar_nfse, 
       :cancelar_nfse, :substituir_nfse, :consultar_lote_rps, 
       :consultar_nfse_por_rps, :consultar_nfse_servico_prestado, 
       :consultar_nfse_servico_tomado, :consultar_nfse_faixa
      ]
    end

    def namespace_tc
      'http://nfse.abrasf.org.br/tipos_complexos.xsd'
    end

    # defines default methods for every operation
    # i.e. build_operation_name_xml and operation_name_xml_namespace
    operations.each do |operation|
      build_xml_method = "build_#{operation}_xml".to_sym
      define_method(build_xml_method) do |hash = {}|
        options = {
          action: get_action_from(__callee__),
          namespace: self.send(get_namespace_method_from(__callee__))
        }
        if block_given?
          build_xml(hash, options, &Proc.new)
        else
          build_xml(hash, options)
        end
      end
      
      xml_namespace_method = "#{operation}_xml_namespace".to_sym
      define_method(xml_namespace_method) do 
        {
          'xmlns' => 'http://nfse.abrasf.org.br',
          'xmlns:tc' => namespace_tc
        }
      end
    end

  end

  def self.extended(base)
    base.extend(ClassMethods)
  end

  def self.included(base)
    base.send(:include, ClassMethods)
  end

end
