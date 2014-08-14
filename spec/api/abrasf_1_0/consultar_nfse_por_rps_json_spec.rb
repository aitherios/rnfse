# -*- coding: utf-8 -*-
require 'spec_helper'

describe "abrasf_1_0/consultar_nfse_por_rps.json" do
  let(:file) do 
    File.join($ROOT, 'lib', 'rnfse', 'api', 'abrasf_1_0', 
              'consultar_nfse_por_rps.json')
  end

  describe "#/" do
    it 'deveria validar os parametros mínimos' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "identificacaoRps": { "numero": 1, "serie": "00000", "tipo": 1 },
          "prestador": {
            "cnpj": "12.552.510/0001-50",
            "inscricaoMunicipal": "68"
          }
        }
      JSON
    end
  end
end
