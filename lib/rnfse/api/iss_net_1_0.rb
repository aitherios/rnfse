# -*- coding: utf-8 -*-

module Rnfse::API::IssNet10
  include Rnfse::API::Abrasf10

  def operations()
    [
      :recepcionar_lote_rps, :consultar_situacao_lote_rps, 
      :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
      :cancelar_nfse, :consultar_url_visualizacao_nfse, 
      :consultar_url_visualizacao_nfse_serie
    ]
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

  def consultar_url_visualizacao_nfse()
    raise Rnfse::Error::NotImplemented
  end

  def consultar_url_visualizacao_nfse_serie()
    raise Rnfse::Error::NotImplemented
  end


end
