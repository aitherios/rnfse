# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::IssNet10 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :iss_net_1_0) }

  describe "#build_recepcionar_lote_rps_xml" do
    let(:xml) do 
      Nokogiri::XML(
        File.read(
          File.join($ROOT, 'spec', 'fixtures', 'iss_net_1_0', 
              'enviar_lote_rps_envio.xml')
        )
      )
    end

    it 'deveria construir o xml com um lote válido' do
      expect(builder.build_recepcionar_lote_rps_xml({
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
              regime_especial_tributacao: true,
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
                  aliquota: 5.00,
                  valor_liquido_nfse: 850,
                  desconto_incondicionado: 0,
                  desconto_condicionado: 0
                },
                item_lista_servico: "12",
                codigo_cnae: "6311-9/00",
                discriminacao: "Borealis",
                codigo_tributacao_municipio: 45217023,
                discriminacao: 'Discriminação da RPS',
                codigo_municipio: 999
              },
              prestador: {
                cnpj: "11.006.269/0001/00",
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
      })).to be_equivalent_to(xml)
    end
  end

end
