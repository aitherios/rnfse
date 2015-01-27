# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::IssNet100
  include Rnfse::XMLBuilder::Abrasf100

  @operations = [ 
    :recepcionar_lote_rps, :consultar_situacao_lote_rps, 
    :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps, 
    :cancelar_nfse
  ]

  @options = {
    all: {
      namespace: {
        'xmlns:tc' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd',
        'xmlns:ts' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_simples.xsd' }},
    recepcionar_lote_rps: { 
      action: 'EnviarLoteRpsEnvio',
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_enviar_lote_rps_envio.xsd' }},
    consultar_lote_rps: {
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_lote_rps_envio.xsd'}},
    consultar_situacao_lote_rps: {
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_situacao_lote_rps_envio.xsd' }},
    consultar_nfse_por_rps: { 
      action: 'ConsultarNfseRpsEnvio',
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_rps_envio.xsd'}},
    consultar_nfse: { 
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_envio.xsd' }},
    cancelar_nfse: { 
      namespace: { 
        'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_envio.xsd' }}
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
    hash = wrap_cpf_cnpj(hash)
    hash = add_municipio_prestacao_servico(hash)
    hash = add_estado(hash)
    hash = add_cidade(hash)
    hash = alter_aliquota(hash)

    hash
  end

  # alterar o formato da aliquota de 0 a 1 para 0 a 100
  def alter_aliquota(hash)
    Rnfse::Hash.transform_values(hash, 'tc:Aliquota') do |val|
      "%.2f" % (val * 100)
    end
  end

  # troca a tag Endereco/CodigoMunicipio por Cidade
  def add_cidade(hash)
    Rnfse::Hash.replace_key_values(hash, 'tc:Endereco/tc:CodigoMunicipio') do |key, value|
      { 'tc:Cidade' => value }
    end
  end

  # troca a tag Uf pela tag Estado
  def add_estado(hash)
    Rnfse::Hash.replace_key_values(hash, 'tc:Uf') do |key, value|
      { :'tc:Estado' => value } 
    end
  end

  # troca a tag CodigoMunicipio para MunicipioPrestacaoServico
  # na tag Servico
  def add_municipio_prestacao_servico(hash)
    Rnfse::Hash.replace_key_values(hash, 'tc:Servico/tc:CodigoMunicipio') do |key, value|
      { :'tc:MunicipioPrestacaoServico' => value }
    end
  end

  # encapsula as tags cpf ou cnpj em uma tag cpfcnpj
  def wrap_cpf_cnpj(hash)
    if hash[:Pedido].nil?
      Rnfse::Hash.replace_key_values(hash, /tc:(Cpf|Cnpj)/) do |key, value|
        { :'tc:CpfCnpj' => { key => value } }
      end
    else
      hash
    end
  end

end
