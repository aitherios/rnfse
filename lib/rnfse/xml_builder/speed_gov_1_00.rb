# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::SpeedGov100
  include Rnfse::XMLBuilder::Abrasf100

  @operations = [ 
    :recepcionar_lote_rps, :consultar_situacao_lote_rps, :consultar_nfse_envio,
    :consultar_nfse_rps_envio, :consultar_situacao_lote_rps_envio,
    :consultar_lote_rps_envio
  ]

  @options = {
    all: {
      namespace: {
        'xmlns:ds' => "http://www.w3.org/2000/09/xmldsig#",
        'xmlns:p1' => "http://ws.speedgov.com.br/tipos_v1.xsd",
        'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance" }},
    recepcionar_lote_rps: {
      action: 'p:EnviarLoteRpsEnvio',
      namespace: {
        'xmlns:p' => "http://ws.speedgov.com.br/enviar_lote_rps_envio_v1.xsd",
        'xsi:schemaLocation' => "http://ws.speedgov.com.br/enviar_lote_rps_envio_v1.xsd" }},
    consultar_situacao_lote_rps: {
      action: 'p:ConsultarSituacaoLoteRpsEnvio',
      namespace: {
        'xmlns:p' => "http://ws.speedgov.com.br/consultar_situacao_lote_rps_envio_v1.xsd",
        'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_situacao_lote_rps_envio_v1.xsd" }},
    consultar_nfse_envio: {
      action: 'p:ConsultarNfseEnvio',
      namespace: {
        'xmlns:p' => "http://ws.speedgov.com.br/consultar_nfse_envio_v1.xsd",
        'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_nfse_envio_v1.xsd" }},
    consultar_nfse_rps_envio: {
      action: 'p:ConsultarNfseRpsEnvio',
      namespace: {
        'xmlns:p' => "http://ws.speedgov.com.br/consultar_nfse_rps_envio_v1.xsd",
        'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_nfse_rps_envio_v1.xsd" }},
    consultar_situacao_lote_rps_envio: {
      action: 'p:ConsultarSituacaoLoteRpsEnvio',
      namespace: {
        'xmlns:p' => "http://ws.speedgov.com.br/consultar_situacao_lote_rps_envio_v1.xsd",
        'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_situacao_lote_rps_envio_v1.xsd" }},
    consultar_lote_rps_envio: {
      action: 'p:ConsultarLoteRpsEnvio',
      namespace: {
      'xmlns:p' => "http://ws.speedgov.com.br/consultar_lote_rps_envio_v1.xsd",
      'xsi:schemaLocation' => "http://ws.speedgov.com.br/consultar_lote_rps_envio_v1.xsd" }}
  }

  inject_builder_methods @operations, @options

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

  def alter_data_before_builder(hash)
    prepare_hash(hash)
  end

  def alter_data_before_recepcionar_lote_rps(hash)
    add_p_namespace(hash, /LoteRps/)
  end

  def alter_data_before_consultar_nfse_envio(hash)
    add_p_namespace(hash, %r{ (Prestador|
                               NumeroNfse|
                               DataInicial|
                               DataFinal|
                               PeriodoEmissao|
                               Tomador|
                               IntermediarioServico) }x)
  end

  def alter_data_before_consultar_nfse_rps_envio(hash)
    add_p_namespace(hash, /(Prestador|IdentificacaoRps)/)
  end

  def alter_data_before_consultar_situacao_lote_rps_envio(hash)
    add_p_namespace(hash, /(Prestador|Protocolo)/)
  end

  def alter_data_before_consultar_lote_rps_envio(hash)
    add_p_namespace(hash, /(Prestador|Protocolo)/)
  end

  private

  def prepare_hash(hash)
    hash = camelize_hash(hash)
    hash = wrap_rps(hash)
    hash = clean_numerics(hash)
    hash = alter_aliquota(hash)
    hash = wrap_cpf_cnpj(hash)
    hash = wrap_data_inicial_data_final(hash)
    hash = fix_booleans(hash)
    hash = add_p1_namespace(hash)
    hash
  end

  # encapsula as tags cpf ou cnpj em uma tag cpfcnpj
  def wrap_cpf_cnpj(hash)
    match = '(IdentificacaoTomador|IntermediarioServico|Tomador)/(Cnpj|Cpf)'
    Rnfse::Hash.replace_key_values(hash, match) do |key, value|
      { :'CpfCnpj' => { key => value } }
    end
  end

  # encapsula as tags data inicial e data final em periodo emissao
  def wrap_data_inicial_data_final(hash)
    if hash[:'DataFinal'] and hash[:'DataInicial']
      hash[:'PeriodoEmissao'] = {
        :'DataInicial' => hash.delete(:'DataInicial'),
        :'DataFinal' => hash.delete(:'DataFinal')
      }
    end
    hash
  end

  # alterar o formato da aliquota de 0 a 1 para 0 a 100
  def alter_aliquota(hash)
    Rnfse::Hash.transform_values(hash, 'Aliquota') do |val|
      "%.1f" % (val * 100)
    end
  end

  def add_p_namespace(hash, regex)
    Rnfse::Hash.transform_keys(hash, regex) do |key|
      "p:#{key.to_s.gsub(/^[^:]+:/, '')}"
    end
  end

  def add_p1_namespace(hash)
    Rnfse::Hash.transform_keys(hash) { |key| "p1:#{key}".to_sym }
  end

end
