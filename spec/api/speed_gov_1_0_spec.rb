# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API::SpeedGov10 do
  let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
  let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }
  let(:client) do
    Rnfse::API.new(padrao: :speed_gov_1_0,
                   namespace: 'http://ws.speedgov.com.br/',
                   endpoint: 'http://speedgov.com.br/wsmod/Nfes',
                   certificate: certificate,
                   key: key)
  end

  describe '#operations' do
    it { expect(client.operations).to eq([
      :recepcionar_lote_rps, :consultar_situacao_lote_rps,
      :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
      :cancelar_nfse
    ]) }
  end

  describe '#recepcionar_lote_rps' do
    context 'ao não passar opções certificate e key para assinatura do xml,' do
      let(:client) do
        Rnfse::API.new(padrao: :abrasf_1_0,
                       namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                       endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx')
      end

      it { expect { client.recepcionar_lote_rps() }.to raise_error(ArgumentError) }
    end

    context 'quando parametros errados são passados,' do
      it { expect{ client.recepcionar_lote_rps(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:recepcionar_lote_rps) }

    subject do
      VCR.use_cassette('speed_gov_1_0_recepcionar_lote_rps') do
        client.recepcionar_lote_rps({
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
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }
  end

  describe '#consultar_situacao_lote_rps' do
    context 'quando parametros errados são passados,' do
      it { expect{ client.consultar_situacao_lote_rps(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:consultar_situacao_lote_rps)  }

    subject do
      VCR.use_cassette('speed_gov_1_0_consultar_situacao_lote_rps') do
        client.consultar_situacao_lote_rps({
          prestador: {
            cnpj: '07.792.435/0009-12',
            inscricao_municipal: '59274734'
          },
          protocolo: '717293e4-3601-4955-865c-5a022c2b5ff5'
        })
      end
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }
  end

  describe '#consultar_nfse_por_rps' do
    context 'quando parametros errados são passados,' do
      it { expect{ client.consultar_nfse_por_rps(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:cancelar_nfse)  }

    subject do
      VCR.use_cassette('speed_gov_1_0_consultar_nfse_por_rps') do
        client.consultar_nfse_por_rps({
          identificacao_rps: { numero: 1, serie: "00000", tipo: 1 },
          prestador: {
            cnpj: "12.552.510/0001-50",
            inscricao_municipal: "68"
          }
        })
      end
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }
  end

  describe '#consultar_nfse' do
    context 'quando parametros errados são passados,' do
      it { expect{ client.consultar_nfse(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:consultar_nfse) }

    subject do
      VCR.use_cassette('speed_gov_1_0_consultar_nfse') do
        client.consultar_nfse({
          prestador: {
            cnpj: "12.552.510/0001-50",
            inscricao_municipal: "68"
          }
        })
      end
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }
  end

  describe '#consultar_lote_rps' do
    it { expect(client).to respond_to(:consultar_lote_rps)  }
    it { expect { client.consultar_lote_rps() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#cancelar_nfse' do
    it { expect(client).to respond_to(:cancelar_nfse)  }
    it { expect { client.cancelar_nfse() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

end
