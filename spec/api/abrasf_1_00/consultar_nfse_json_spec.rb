# -*- coding: utf-8 -*-
require 'spec_helper'

describe "abrasf_1_00/consultar_nfse.json" do
  let(:file) do 
    File.join($ROOT, 'lib', 'rnfse', 'api', 'abrasf_1_00', 
              'consultar_nfse.json')
  end

  describe "#/" do
    it 'deveria validar os parametros mínimos' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "prestador": {
            "cnpj": "12.552.510/0001-50",
            "inscricaoMunicipal": "68"
          }
        }
      JSON
    end

    it 'deveria validar os parametros completos' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "prestador": {
            "cnpj": "12.552.510/0001-50",
            "inscricaoMunicipal": "68"
          },
          "numeroNfse": 201400000000001,
          "dataInicial": "2013-04-21T21:42:42-03:00",
          "dataFinal": "2014-04-21T21:42:42-03:00",
          "tomador": {
            "cnpj": "38.421.846/0001-78",
            "inscricaoMunicipal": "12345679"
          },
          "intermediarioServico": {
            "razaoSocial": "Black Mesa Research Facility",
            "cnpj": "62.894.995/0001-39",
            "inscricaoMunicipal": "12345670"
          }
        }
      JSON
    end
  end
end
