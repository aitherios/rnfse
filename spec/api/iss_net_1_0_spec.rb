# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API::IssNet10 do
  let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
  let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }

  
  let(:client) do
    Rnfse::API.new(padrao: :iss_net_1_0, 
                   namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                   endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx',
                   certificate: certificate,
                   key: key)
    end


  describe '#recepcionar_lote_rps' do
    context 'quando parametros errados são passados,' do
      it { expect{ client.recepcionar_lote_rps(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:recepcionar_lote_rps) }

    subject do
      VCR.use_cassette('iss_net_1_0_recepcionar_lote_rps') do
        client.recepcionar_lote_rps({
          lote_rps: {
            numero_lote: 1,
            cnpj: "14.576.582/0001-63",
            inscricao_municipal: "124762",
            quantidade_rps: 1,
            lista_rps: [
              {
                identificacao_rps: { numero: 15, serie: "8", tipo: 1 },
                data_emissao: "2014-06-24T10:00:00",
                natureza_operacao: 1,
                optante_simples_nacional: false,
                incentivador_cultural: false,
                status: 1,
                regime_especial_tributacao: 1,
                servico: {
                  valores: {
                    valor_servicos: 35,
                    valor_pis: 0,
                    valor_cofins: 0,
                    valor_inss: 0,
                    valor_ir: 0,
                    valor_csll: 0,
                    iss_retido: false,
                    valor_iss: 0,
                    base_calculo: 35,
                    aliquota: 0.05,
                    valor_liquido_nfse: 35,
                    desconto_incondicionado: 0,
                    desconto_condicionado: 0
                  },
                  item_lista_servico: "8",
                  codigo_cnae: "6399-2/00",
                  discriminacao: "Borealis",
                  codigo_tributacao_municipio: "50000024",
                  discriminacao: 'Discriminação da RPS',
                  codigo_municipio: 999
                },
                prestador: {
                  cnpj: "14.576.582/0001-63",
                  inscricao_municipal: "124762"
                },
                tomador: {
                  identificacao_tomador: {
                    cpf: "935.659.688-34",
                  },
                  razao_social: 'José Serra',
                  endereco: {
                    endereco: 'R dos Navegantes 123, 321',
                    numero: '123',
                    complemento: '321',
                    bairro: 'Boa Viagem',
                    codigo_municipio: 1,
                    uf: 'PE',
                    cep: '51021-010'
                  }
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

  describe '#cancelar_nfse'
  describe '#consultar_nfse_por_rps'
  describe '#consulta_situacao_lote_rps'
  describe '#consultar_url_visualizacao_nfse'
  describe '#consultar_url_visualizacao_nfse_serie'
end
