# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API::Sia201 do
  let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
  let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }
  let(:client) do
    Rnfse::API.new(padrao: :sia_2_01,
                   namespace: 'http://ws.issweb.fiorilli.com.br/',
                   endpoint: 'http://201.28.69.146:5663/IssWeb-ejb/IssWebWS/IssWebWS',
                   certificate: certificate,
                   key: key,
                   verbose: true)
  end

  describe '#operations' do
    it { expect(client.operations).to eq([
      :cancelar_nfse, :consultar_lote_rps, :consultar_nfse_faixa, 
      :consultar_nfse_por_rps, :consultar_nfse_servico_prestado, 
      :consultar_nfse_servico_tomado, :gerar_nfse, :recepcionar_lote_rps, 
      :recepcionar_lote_rps_sincrono, :substituir_nfse
    ]) }
  end

  describe '#recepcionar_lote_rps' do
    it { expect(client).to respond_to(:recepcionar_lote_rps) }

    subject do
      # VCR.use_cassette('speed_gov_2_01_recepcionar_lote_rps') do
        client.recepcionar_lote_rps(
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
        )
      # end
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }

  end
end
