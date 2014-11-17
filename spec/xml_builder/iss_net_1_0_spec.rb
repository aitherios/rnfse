# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::IssNet10 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :iss_net_1_0) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'iss_net_1_0') }

  describe "#build_recepcionar_lote_rps_xml" do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'enviar_lote_rps_envio.xml')))
    end

    subject do
      builder.build_recepcionar_lote_rps_xml({
        lote_rps: {
          numero_lote: 1,
          cnpj: "11.006.269/0001-00",
          inscricao_municipal: "812005",
          quantidade_rps: 1,
          lista_rps: [
            {
              identificacao_rps: { numero: 215, serie: "10", tipo: 1 },
              data_emissao: "2009-07-24T10:00:00",
              natureza_operacao: 1,
              optante_simples_nacional: false,
              incentivador_cultural: false,
              status: 1,
              regime_especial_tributacao: 1,
              servico: {
                valores: {
                  valor_servicos: 1100,
                  valor_pis: 10,
                  valor_cofins: 20,
                  valor_inss: 30,
                  valor_ir: 40,
                  valor_csll: 50,
                  iss_retido: false,
                  valor_iss: 50,
                  base_calculo: 1000,
                  aliquota: 0.05,
                  valor_liquido_nfse: 850,
                  desconto_incondicionado: 0,
                  desconto_condicionado: 0
                },
                item_lista_servico: "12",
                codigo_cnae: "6311-9/00",
                discriminacao: "Borealis",
                codigo_tributacao_municipio: "45217023",
                discriminacao: 'Discriminação da RPS',
                codigo_municipio: 999
              },
              prestador: {
                cnpj: "11.006.269/0001-00",
                inscricao_municipal: "812005"
              },
              tomador: {
                identificacao_tomador: {
                  cnpj: "38.693.524/0001-88"
                },
                razao_social: 'Empresa do Recife',
                endereco: {
                  endereco: 'R dos Navegantes 123, 321',
                  numero: '123',
                  complemento: '321',
                  bairro: 'Boa Viagem',
                  codigo_municipio: 261160,
                  uf: 'PE',
                  cep: '51021-010'
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
        identificacao_rps: { numero: 210, serie: "10", tipo: 1 },
        prestador: {
          cpf: '970.047.311-20',
          inscricao_municipal: '812005'
        }
      })
    end
    
    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }

  end

  describe '#build_consultar_nfse_xml' do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_nfse.xml')))
    end

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

  describe '#build_consultar_lote_rps_xml' do
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
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'cancelar_nfse_envio.xml')))
    end

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
