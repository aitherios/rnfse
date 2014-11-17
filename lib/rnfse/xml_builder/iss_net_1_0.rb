# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::IssNet10
  include Rnfse::XMLBuilder::Abrasf10

  private

  # prepara um hash para ser convertido a xml com o Gyoku
  def prepare_hash(hash)
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

  # namespace dos tipos complexos
  def xmlns_tc
    'http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd'
  end  

  # namespace dos tipos simples
  def xmlns_ts
    'http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_simples.xsd'
  end

  # namespaces do xml recepcionar_lote_rps
  def build_recepcionar_lote_rps_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_enviar_lote_rps_envio.xsd',
      'xmlns:tc' => xmlns_tc
    }
  end

  # namespaces do xml consultar_situacao_lote_rps
  def build_consultar_situacao_lote_rps_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_situacao_lote_rps_envio.xsd',
      'xmlns:tc' => xmlns_tc
    }
  end

  # namespaces do xml consultar_lote_rps
  def build_consultar_lote_rps_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_lote_rps_envio.xsd',
      'xmlns:tc' => xmlns_tc,
      'xmlns:ts' => xmlns_ts
    }
  end

  # namespaces do xml consultar_nfse_por_xml
  def build_consultar_nfse_por_rps_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_rps_envio.xsd',
      'xmlns:tc' => xmlns_tc,
      'xmlns:ts' => xmlns_ts
    }
  end

  # namespaces do xml consultar_nfse
  def build_consultar_nfse_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_envio.xsd',
      'xmlns:tc' => xmlns_tc
    }
  end

  # namespaces do xml cancelar_nfse
  def build_cancelar_nfse_xmlns
    {
      'xmlns' => 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_envio.xsd',
      'xmlns:tc' => xmlns_tc
    }
  end

end
