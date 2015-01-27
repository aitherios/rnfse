# -*- coding: utf-8 -*-

module Rnfse::API::IssNet100
  include Rnfse::API::Abrasf100

  def operations
    [
      :recepcionar_lote_rps, :consultar_situacao_lote_rps, 
      :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
      :cancelar_nfse, :consultar_url_visualizacao_nfse, 
      :consultar_url_visualizacao_nfse_serie
    ].sort
  end

  def recepcionar_lote_rps(hash = {})
    validate_sign_options
    validate_options(hash)
    xml = xml_builder.build_recepcionar_lote_rps_xml(hash)
    xml.sign!(certificate: File.read(self.certificate), key: File.read(self.key))
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
      soap_action: 'ConsultarSituacaoLoteRPS',
      message_tag: 'ConsultarSituacaoLoteRPS',
      message: { :'xml!' => "<![CDATA[#{xml}]]>" })
    parse_response(response)
  end

  def consultar_nfse_por_rps(hash = {})
    validate_options(hash)
    xml = xml_builder.build_consultar_nfse_por_rps_xml(hash)
    response = self.soap_client.call(
      :consultar_nfse_por_rps,
      soap_action: 'ConsultarNFSePorRPS',
      message_tag: 'ConsultarNFSePorRPS',
      message: { :'xml!' => "<![CDATA[#{xml}]]>" })
    parse_response(response)
  end

  def consultar_url_visualizacao_nfse(hash = {})
    raise Rnfse::Error::NotImplemented
  end

  def consultar_url_visualizacao_nfse_serie(hash = {})
    raise Rnfse::Error::NotImplemented
  end

end
