# -*- coding: utf-8 -*-
require 'spec_helper'

describe "abrasf_1_0/recepcionar_lote_rps.json" do
  let(:file) do 
    File.join($ROOT, 'lib', 'rnfse', 'api', 'abrasf_1_0', 
              'recepcionar_lote_rps.json')
  end

  describe "#/loteRps" do
    it 'deveria validar' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "loteRps": {
             "numeroLote": 2,
             "cnpj": "44.141.526/0001-67",
             "inscricaoMunicipal": "12345678",
             "quantidadeRps": 1,
             "listaRps": [
               {
                 "identificacaoRps": { "numero": 2, "serie": "8", "tipo": 1 },
                 "dataEmissao": "1960-04-21T21:42:42-03:00",
                 "naturezaOperacao": 1,
                 "regimeEspecialTributacao": 1,
                 "optanteSimplesNacional": false,
                 "incentivadorCultural": false,
                 "status": 1,
                 "rpsSubstituido": { "numero": 1, "serie": "8", "tipo": 1 },
                 "servico": {
                   "valores": {
                     "valorServicos": 10.42,
                     "valorDeducoes": 0.1,
                     "valorPis": 0.2,
                     "valorCofins": 0.3,
                     "valorInss": 0.4,
                     "valorIr": 0.5,
                     "valorCsll": 0.6,
                     "issRetido": true,
                     "valorIss": 0.7,
                     "outrasRetencoes": 0.8,
                     "baseCalculo": 9.32,
                     "aliquota": 0,
                     "valorLiquidoNfse": 4.62,
                     "valorIssRetido": 1.1,
                     "descontoCondicionado": 0.9,
                     "descontoIncondicionado": 1
                   }
                 },
                 "prestador": {
                   "cnpj": "44.141.526/0001-67",
                   "inscricaoMunicipal": "12345678"
                 },
                 "tomador": {
                   "identificacaoTomador": {
                     "cnpj": "38.421.846/0001-78",
                     "inscricaoMunicipal": "12345679"
                   }
                 }
               }
             ]
          }
        }
      JSON
    end
  end
  
end
