# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Abrasf202 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :abrasf_2_02) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'abrasf_2_02') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

  describe '#build_recepcionar_lote_rps_xml' do
    let!(:filename) { 'enviar_lote_rps_envio.xml' }

    subject do 
      builder.build_recepcionar_lote_rps_xml({
        lote_rps: {
          numero_lote: 2,
          cnpj: "44.141.526/0001-67",
          inscricao_municipal: "12345678",
          quantidade_rps: 1,
          lista_rps: [
            {
              identificacao_rps: { numero: 2, serie: "8", tipo: 1 },
              data_emissao: "1960-04-21T21:42:42-03:00",
              natureza_operacao: 1,
              optante_simples_nacional: false,
              incentivador_cultural: false,
              status: 1,
              servico: {
                valores: {
                  valor_servicos: 10.42,
                  iss_retido: false,
                  base_calculo: 10.42
                },
                item_lista_servico: "00001",
                discriminacao: "Borealis",
                codigo_municipio: 5300108
              },
              prestador: {
                cnpj: "44.141.526/0001-67",
                inscricao_municipal: "12345678"
              },
              tomador: {
                identificacao_tomador: {
                  cnpj: "38.421.846/0001-78",
                  inscricao_municipal: "12345679"
                }
              }
            },
            {
              identificacao_rps: { numero: 3, serie: "8", tipo: 1 },
              data_emissao: "1960-04-21T21:42:42-03:00",
              natureza_operacao: 1,
              optante_simples_nacional: false,
              incentivador_cultural: false,
              status: 1,
              servico: {
                valores: {
                  valor_servicos: 10.42,
                  iss_retido: false,
                  base_calculo: 10.42
                },
                item_lista_servico: "00001",
                discriminacao: "Borealis",
                codigo_municipio: 5300108
              },
              prestador: {
                cnpj: "44.141.526/0001-67",
                inscricao_municipal: "12345678"
              },
              tomador: {
                identificacao_tomador: {
                  cnpj: "38.421.846/0001-78",
                  inscricao_municipal: "12345679"
                }
              }
            }
          ]
        }
      }) 
    end

    it { is_expected.not_to be_equivalent_to(xml) }
    it { is_expected.to be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_recepcionar_lote_rps_sincrono_xml'
  describe '#build_gerar_nfse_xml'
  describe '#build_cancelar_nfse_xml'
  describe '#build_substuir_nfse_xml'
  describe '#build_consultar_lote_rps_xml'
  describe '#build_consultar_nfse_por_rps_xml'
  describe '#build_consultar_nfse_servico_prestado_xml'
  describe '#build_consultar_nfse_servico_tomado_xml'
  describe '#build_consultar_nfse_faixa_xml'
  
end
