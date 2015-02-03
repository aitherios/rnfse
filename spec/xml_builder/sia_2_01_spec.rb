# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Sia201 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :sia_2_01) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'sia_2_01') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

  describe '#build_recepcionar_lote_rps_xml' do
    let!(:filename) { 'enviar_lote_rps_envio.xml' }
    subject do 
      builder.build_recepcionar_lote_rps_xml({
        lote_rps: {
          numero_lote: 1,
          cpf_cnpj: { cnpj: '01001001000113' },
          inscricao_municipal: '1.000.10',
          quantidade_rps: 1,
          lista_rps: {
            rps: [
              {
                inf_declaracao_prestacao_servico: {
                  rps: {
                    identificacao_rps: { numero: 1, serie: '999', tipo: 1 },
                    data_emissao: '2013-05-13',
                    status: 1
                  },
                  competencia: '2013-05-13',
                  servico: {
                    valores: { 
                      valor_servicos: '100.00',
                      valor_deducoes: '1.00',
                      valor_pis: '2.00',
                      valor_cofins: '3.00',
                      valor_inss: '4.00',
                      valor_ir: '5.00',
                      valor_csll: '6.00',
                      outras_retencoes: '7.00',
                      valor_iss: '8.00',
                      aliquota: '2.0000'
                    },
                    iss_retido: 2,
                    responsavel_retencao: 1,
                    item_lista_servico: '01.05',
                    discriminacao: 'descricao do servico',
                    codigo_municipio: 3505203,
                    codigo_pais: '1058',
                    exibilidade_iss: 1
                  },
                  prestador: {
                    cpf_cnpj: { cnpj: '01001001000113' },
                    inscricao_municipal: '1.000.10'
                  },
                  tomador: {
                    identificacao_tomador: {
                      cpf_cnpj: { cpf: '27600930854' },
                    },
                    razao_social: 'Ivan Moraes',
                    endereco: { 
                      endereco: 'Av Jose Goncalves',
                      numero: '93',
                      complemento: 'Casa',
                      bairro: 'Santa Rosa',
                      codigo_municipio: 3505203,
                      uf: 'SP',
                      codigo_pais: '1058',
                      cep: '17250000'
                    },
                    contato: {
                      telefone: '36620000',
                      email: 'ivantgm@gmail.com'
                    }
                  },
                  optante_simples_nacional: 2,
                  incentivo_fiscal: 2
                }
              },
              {
                inf_declaracao_prestacao_servico: {
                  rps: {
                    identificacao_rps: { numero: 2, serie: '999', tipo: 1 },
                    data_emissao: '2013-05-13',
                    status: 1
                  },
                  competencia: '2013-05-13',
                  servico: {
                    valores: { 
                      valor_servicos: '100.00',
                      valor_deducoes: '1.00',
                      valor_pis: '2.00',
                      valor_cofins: '3.00',
                      valor_inss: '4.00',
                      valor_ir: '5.00',
                      valor_csll: '6.00',
                      outras_retencoes: '7.00',
                      valor_iss: '8.00',
                      aliquota: '2.0000'
                    },
                    iss_retido: 2,
                    responsavel_retencao: 1,
                    item_lista_servico: '01.05',
                    discriminacao: 'descricao do servico',
                    codigo_municipio: 3505203,
                    codigo_pais: '1058',
                    exibilidade_iss: 1
                  },
                  prestador: {
                    cpf_cnpj: { cnpj: '01001001000113' },
                    inscricao_municipal: '1.000.10'
                  },
                  tomador: {
                    identificacao_tomador: {
                      cpf_cnpj: { cpf: '27600930854' },
                    },
                    razao_social: 'Ivan Moraes',
                    endereco: { 
                      endereco: 'Av Jose Goncalves',
                      numero: '93',
                      complemento: 'Casa',
                      bairro: 'Santa Rosa',
                      codigo_municipio: 3505203,
                      uf: 'SP',
                      codigo_pais: '1058',
                      cep: '17250000'
                    },
                    contato: {
                      telefone: '36620000',
                      email: 'ivantgm@gmail.com'
                    }
                  },
                  optante_simples_nacional: 2,
                  incentivo_fiscal: 2
                }
              }
            ]
          }
        }
      }) 
    end

    it { is_expected.to be_equivalent_to(xml) }
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
