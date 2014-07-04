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
                 "optanteSimplesNacional": false,
                 "incentivadorCultural": false,
                 "status": 1,
                 "servico": {
                   "valores": {
                     "valorServicos": 10.42,
                     "issRetido": false,
                     "baseCalculo": 9.32
                   },
                   "itemListaServico": "00001",
                   "discriminacao": "Borealis",
                   "codigoMunicipio": 5300108
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
               },
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
                   },
                   "itemListaServico": "00001",
                   "codigoCnae": "0000-0/00",
                   "codigoTributacaoMunicipio": "00001",
                   "discriminacao": "Borealis",
                   "codigoMunicipio": 5300108
                 },
                 "prestador": {
                   "cnpj": "44.141.526/0001-67",
                   "inscricaoMunicipal": "12345678"
                 },
                 "tomador": {
                   "identificacaoTomador": {
                     "cnpj": "38.421.846/0001-78",
                     "inscricaoMunicipal": "12345679"
                   },
                   "razaoSocial": "Aperture Science Enrichment Center",
                   "endereco": {
                      "endereco": "Rua Vital Apparatus Vent",
                      "numero": "42",
                      "complemento": "Morality Core",
                      "bairro": "GLaDOS",
                      "codigoMunicipio": 5300108,
                      "uf": "DF",
                      "cep": "70000-000"
                   },
                   "contato": {
                     "telefone": "61 80000000",
                     "email": "glados@aperture.com"
                   }
                 },
                 "intermediarioServico": {
                   "razaoSocial": "Black Mesa Research Facility",
                   "cnpj": "62.894.995/0001-39",
                   "inscricaoMunicipal": "12345670"
                 },
                 "construcaoCivil": {
                   "codigoObra": "1008",
                   "art": "3000-D CAU/BR"
                 }
               }
             ]
          }
        }
      JSON
    end
  end
  
end
