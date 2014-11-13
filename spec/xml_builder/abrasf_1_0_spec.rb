# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Abrasf10 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :abrasf_1_0) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'abrasf_1_0') }

  describe "#build_recepcionar_lote_rps_xml" do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'enviar_lote_rps_envio.xml')))
    end

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
            }
          ]
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_situacao_lote_rps_xml' do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_situacao_lote_rps_envio.xml')))
    end

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
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_nfse_por_rps.xml')))
    end

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
    it { expect(builder).to respond_to(:build_consultar_nfse_xml) }
    it { expect { builder.build_consultar_nfse_xml() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe "#build_consultar_lote_rps_xml" do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_lote_rps_envio.xml')))
    end

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
    it { expect(builder).to respond_to(:build_cancelar_nfse_xml) }
    it { expect { builder.build_cancelar_nfse_xml() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

end
