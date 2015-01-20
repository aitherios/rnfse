# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Abrasf100 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :abrasf_1_00) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'abrasf_1_00') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

  describe "#build_recepcionar_lote_rps_xml" do
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

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_situacao_lote_rps_xml' do
    let!(:filename) { 'consultar_situacao_lote_rps_envio.xml' }

    subject do
      builder.build_consultar_situacao_lote_rps_xml({
        prestador: {
          cnpj: "14.576.582/0001-63",
          inscricao_municipal: "124762"
        },
        protocolo: "db1c3e91-6aea-4450-a3fc-5b6a7fba7dc7"
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_nfse_por_rps_xml' do
    let!(:filename) { 'consultar_nfse_por_rps.xml' }

    subject do 
      builder.build_consultar_nfse_por_rps_xml({
        identificacao_rps: { numero: 2, serie: "8", tipo: 1 },
        prestador: {
          cnpj: "14.576.582./0001-63",
          inscricao_municipal: "124762"
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_nfse_xml' do
    let!(:filename) { 'consultar_nfse.xml' }

    subject do
      builder.build_consultar_nfse_xml({
        prestador: {
          cnpj: '09.255.435/0001-51',
          inscricao_municipal: '1000017840'
        },
        numero_nfse: '93',
        data_inicial: '2009-08-01',
        data_final: '2009-08-30',
        tomador: {
          cnpj: '38.693.524/0001-88',
          inscricao_municipal: '812005'
        },
        intermediario_servico: {
          cnpj: '38.693.524/0001-88',
          razao_social: 'sdfsfsdfsf',
          inscricao_municipal: '812005'
        }
      })
    end
    
    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe "#build_consultar_lote_rps_xml" do
    let!(:filename) { 'consultar_lote_rps_envio.xml' }

    subject do 
      builder.build_consultar_lote_rps_xml({
        prestador: {
          cpf: "970.047.311-20",
          inscricao_municipal: "812005"
        },
        protocolo: "5afd8f42-cc1e-4657-9249-8fbc3f133ebf"
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_cancelar_nfse_xml' do
    let!(:filename) { 'cancelar_nfse_envio.xml' }

    subject do
      builder.build_cancelar_nfse_xml({
        identificacao_nfse: {
          numero: 15,
          cnpj: '02.956.773/0001-71',
          inscricao_municipal: '1998010',
          codigo_municipio: '999'
        },
        codigo_cancelamento: '5'
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

end
