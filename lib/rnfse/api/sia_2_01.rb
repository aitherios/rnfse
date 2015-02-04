# -*- coding: utf-8 -*-

module Rnfse::API::Sia201
  include Rnfse::API::Abrasf202

  def recepcionar_lote_rps(hash = {})
    xml = xml_builder.build_recepcionar_lote_rps_xml(hash)

    username = Nokogiri::XML::Node.new('username', xml)
    username.content = '01001001000113'
    password = Nokogiri::XML::Node.new('password', xml)
    password.content = '123456'

    response = self.soap_client.call(
      :recepcionar_lote_rps,
      soap_action: 'recepcionarLoteRps',
      message_tag: 'ws:recepcionarLoteRps',
      message: "#{xml}<username>01001001000113</username><password>123456</password>")
  end

  private

  def savon_client_options
    {
      soap_version: 1,
      env_namespace: :soapenv,
      namespaces: { 'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
                    'xmlns:ws' => 'http://ws.issweb.fiorilli.com.br/',
                    'xmlns' => '' },
      namespace_identifier: nil,
      ssl_verify_mode: :peer,
      ssl_cert_file: self.certificate,
      ssl_cert_key_file: self.key,
      endpoint: self.endpoint,
      namespace: self.namespace
    }
  end

end

