# -*- coding: utf-8 -*-
require 'spec_helper'

describe "abrasf_1_0/consultar_situacao_lote_rps.json" do
  let(:file) do 
    File.join($ROOT, 'lib', 'rnfse', 'api', 'abrasf_1_0', 
              'consultar_situacao_lote_rps.json')
  end

  describe "#/" do
    it 'deveria validar' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "prestador": {
            "cnpj": "44.141.526/0001-67",
            "inscricaoMunicipal": "12345678"
          },
          "protocolo": "db1c3e91-6aea-4450-a3fc-5b6a7fba7dc7"
        }
      JSON
    end
  end
end
