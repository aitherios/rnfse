# -*- coding: utf-8 -*-

# Construtor dos xmls das soap actions do padrão Abrasf 1.00.
# Inclui um método público para cada operação.
#
# ==== Operations
#
# * RecepcionarLoteRps 
# * ConsultarSituacaoLoteRps
# * ConsultarNfsePorRps
# * ConsultarNfse
# * ConsultarLoteRps
# * CancelarNfse
#
#   Os métodos públicos são baseados nos nomes em snake_case.
#   E.g. RecepcionarLoteRps vira build_recepcionar_lote_rps_xml
#
#   Para mais detalhes veja a seção de documentação do README.md
module Rnfse::XMLBuilder::Abrasf100
  include Rnfse::XMLBuilder::Base

  @operations = [ 
    :recepcionar_lote_rps, :consultar_situacao_lote_rps, 
    :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps, 
    :cancelar_nfse
  ]

  @options = {
    all: {
      namespace: {
        'xmlns:tc' => 'http://www.abrasf.org.br/tipos_complexos.xsd' }},
    recepcionar_lote_rps: { 
      action: 'EnviarLoteRpsEnvio',
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_enviar_lote_rps_envio.xsd' }},
    consultar_lote_rps: {
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_consultar_lote_rps_envio.xsd' }},
    consultar_situacao_lote_rps: {
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_consultar_situacao_lote_rps_envio.xsd' }},
    consultar_nfse_por_rps: { 
      action: 'ConsultarNfseRpsEnvio',
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_consultar_situacao_lote_rps_envio.xsd' }},
    consultar_nfse: { 
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_consultar_nfse_envio.xsd' }},
    cancelar_nfse: { 
      namespace: { 
        'xmlns' => 'http://www.abrasf.org.br/servico_cancelar_nfse_envio.xsd' }}
  }

  inject_builder_methods @operations, @options

  private

  # prepara um hash para ser convertido a xml com o Gyoku
  def alter_data_before_builder(hash)
    hash = camelize_hash(hash)
    hash = wrap_rps(hash)
    hash = wrap_periodo_emissao(hash)
    hash = wrap_identificacao_nfse(hash)
    hash = add_tc_namespace(hash)
    hash = clean_numerics(hash)
    hash = date_to_utc(hash)
    hash = fix_booleans(hash)
    hash
  end
  
  # converte booleanos para 1 ou 2
  def fix_booleans(hash)
    regex = /((?<!Valor)IssRetido|OptanteSimplesNacional|IncentivadorCultural)\Z/
    Rnfse::Hash.transform_values(hash, regex) do |val|
      val ? 1 : 2
    end
  end
    
  # converte datas para GMT-0
  def date_to_utc(hash)
    Rnfse::Hash.transform_values(hash, /DataEmissao\Z/) do |val|
      DateTime.parse(val.to_s).new_offset(0).strftime('%FT%T')
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
    if hash[:LoteRps]
      hash[:LoteRps][:ListaRps] = {
        :Rps => hash[:LoteRps][:ListaRps].map { |rps| { :InfRps => rps} }
      }
    end
    hash
  end

  # encapsula as tags data_inicial e data_final em periodo_emissao
  def wrap_periodo_emissao(hash)
    if hash[:DataInicial] or hash[:DataFinal]
      hash[:PeriodoEmissao] = {
        :DataInicial => hash.delete(:DataInicial),
        :DataFinal => hash.delete(:DataFinal)
      }
    end
    hash
  end

  # encapsula a tag identificacao_nfse
  def wrap_identificacao_nfse(hash)
    if hash[:IdentificacaoNfse]
      hash[:Pedido] = { 
        :InfPedidoCancelamento => {
          :IdentificacaoNfse => hash.delete(:IdentificacaoNfse),
          :CodigoCancelamento => hash.delete(:CodigoCancelamento)
        }
      }
    end
    hash
  end

  # adiciona o namespace tc nas tags dentro de loteRps ou prestador
  def add_tc_namespace(hash)
    regex = %r{ \A(
                  LoteRps|
                  Prestador|
                  IdentificacaoRps|
                  Tomador|
                  IntermediarioServico|
                  Pedido
                )\Z }x
    Rnfse::Hash.replace_key_values(hash, regex) do |key, value|
      { key => Rnfse::Hash.transform_keys(value) { |k| "tc:#{k}".to_sym } }
    end
  end

end
