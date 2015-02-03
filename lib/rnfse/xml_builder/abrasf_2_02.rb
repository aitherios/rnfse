# -*- coding: utf-8 -*-

# Construtor dos xmls das soap actions do padrão Abrasf 2.02.
# Inclui um método público para cada operação.
#
# ==== Operations
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
#   Os métodos públicos são baseados nos nomes em snake_case.
#   E.g. RecepcionarLoteRps vira build_recepcionar_lote_rps_xml
#
#   Para mais detalhes veja a seção de documentação do README.md
module Rnfse::XMLBuilder::Abrasf202
  include Rnfse::XMLBuilder::Base
  include Rnfse::XMLBuilder::Helper

  @operations = [
    :recepcionar_lote_rps, :recepcionar_lote_rps_sincrono, :gerar_nfse,
    :cancelar_nfse, :substituir_nfse, :consultar_lote_rps, 
    :consultar_nfse_por_rps, :consultar_nfse_servico_prestado,
    :consultar_nfse_servico_tomado, :consultar_nfse_faixa
  ]

  @options = {
    all: {
      namespace: {
        xmlns: 'http://www.abrasf.org.br/nfse.xsd' }},
    recepcionar_lote_rps: { 
      action: 'EnviarLoteRpsEnvio' },
    recepcionar_lote_rps_sincrono: { 
      action: 'EnviarLoteRpsSincronoEnvio' },
    consultar_nfse_por_rps: { 
      action: 'ConsultarNfseRpsEnvio' },
    consultar_nfse_servico_prestado: { 
      action: 'ConsultarNfseEnvio' },
    consultar_nfse_servico_tomado: { 
      action: 'ConsultarNfseEnvio' }
  }

  inject_builder_methods @operations, @options

end
