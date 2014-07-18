# -*- coding: utf-8 -*-
require 'json-schema'

module Rnfse::API::IssNet10
  include Rnfse::API::Abrasf10

  def consultar_situacao_lote_rps(hash = {})
    validate(hash)
    xml = xml_builder.build_consultar_situacao_lote_rps_xml(hash)
    response = self.soap_client.call(
      :consultar_situacao_lote_rps,
      soap_action: 'ConsultarSituacaoLoteRPS',
      message_tag: 'ConsultarSituacaoLoteRPS',
      message: { :'xml!' => "<![CDATA[#{xml}]]>" })
    parse_response(response)
  end

end
