# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::IssNet10 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :speed_gov_1_0) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'speed_gov_1_0') }

  describe "#build_recepcionar_lote_rps_xml" do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'enviar_lote_rps_envio.xml')))
    end

    subject do
      builder.build_recepcionar_lote_rps_xml({
        lote_rps: {
          numero_lote: 1,
          cnpj: "12.552.510/0001-50",
          inscricao_municipal: "68",
          quantidade_rps: 1,
          lista_rps: [
            {
              identificacao_rps: { numero: 1, serie: "00000", tipo: 1 },
              data_emissao: "2013-10-01T08:10:00",
              natureza_operacao: 1,
              optante_simples_nacional: false,
              incentivador_cultural: false,
              status: 1,
              servico: {
                valores: {
                  valor_servicos: 500.0,
                  valor_deducoes: 0.0,
                  valor_pis: 0.0,
                  valor_cofins: 0.0,
                  valor_inss: 0.0,
                  valor_ir: 0.0,
                  valor_csll: 0.0,
                  iss_retido: false,
                  valor_iss: 10.0,
                  valor_iss_retido: 0.0,
                  outras_retencoes: 0.0,
                  base_calculo: 500.0,
                  aliquota: 0.02,
                  valor_liquido_nfse: 490.0,
                  desconto_condicionado: 0.0,
                  desconto_incondicionado: 0.0
                },
                item_lista_servico: "101",
                codigo_cnae: "6201-5/00",
                codigo_tributacao_municipio: "620150000",
                discriminacao: "Borealis",
                codigo_municipio: 9999999
              },
              prestador: {
                cnpj: "12.552.510/0001-50",
                inscricao_municipal: "68"
              },
              tomador: {
                identificacao_tomador: {
                  cnpj: "12.477.945/0001-88"
                },
                razao_social: 'Black Mesa Research Facility',
                endereco: {
                  endereco: 'RUA VICENTE F. GOES',
                  numero: '182',
                  complemento: 'A',
                  bairro: 'ALTO DA MANGUEIRA',
                  codigo_municipio: 9999999,
                  uf: 'CE',
                  cep: '61900-000'
                },
                contato: {
                  telefone: '8512341234',
                  email: 'teste@fes.com.br'
                }
              },
              intermediario_servico: {
                razao_social: 'Intersol Servicos Ltda',
                cpf: '897.461.043-49',
                inscricao_municipal: '1234567'
              }
            }
          ]
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_nfse_envio_xml' do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_nfse_envio.xml')))
    end

    subject do
      builder.build_consultar_nfse_envio_xml({
        prestador: {
          cnpj: "07.792.435/0009-12",
          inscricao_municipal: "59274734"
        },
        numero_nfse: '201400000000001',
        data_inicial: "2013-04-21T21:42:42-03:00",
        data_final: "2014-04-21T21:42:42-03:00",
        tomador: {
          cnpj: "38.421.846/0001-78",
          inscricao_municipal: "12345679"
        },
        intermediario_servico: {
          razao_social: "Black Mesa Research Facility",
          cnpj: "62.894.995/0001-39",
          inscricao_municipal: "12345670"
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_nfse_rps_envio_xml' do
    let(:xml) do
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_nfse_rps_envio.xml')))
    end

    subject do
      builder.build_consultar_nfse_rps_envio_xml({
        identificacao_rps: { numero: 1, serie: "00000", tipo: 1 },
        prestador: {
          cnpj: "12.552.510/0001-50",
          inscricao_municipal: "68"
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_consultar_situacao_lote_rps_envio_xml' do
    let(:xml) do
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_situacao_lote_rps_envio.xml')))
    end

    subject do
      builder.build_consultar_situacao_lote_rps_envio_xml({
        prestador: {
          cnpj: '07.792.435/0009-12',
          inscricao_municipal: '59274734'
        },
        protocolo: '717293e4-3601-4955-865c-5a022c2b5ff5'
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_header_xml' do
    let(:xml) do
      Nokogiri::XML(File.read(File.join(xml_path, 'header.xml')))
    end

    subject do
      builder.build_header_xml()
    end
    
    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

end
