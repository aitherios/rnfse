# -*- coding: utf-8 -*-
require 'spec_helper'

describe "abrasf_1_0/cancelar_nfse.json" do
  let(:file) do 
    File.join($ROOT, 'lib', 'rnfse', 'api', 'abrasf_1_0', 
              'cancelar_nfse.json')
  end

  describe '#/' do
    it 'deveria validar' do
      expect(JSON::Validator.fully_validate(file, <<-'JSON')).to be_empty
        {
          "identificacaoNfse": {
            "numero": 201400000000001,
            "cnpj": "02.956.773/0001-71",
            "inscricaoMunicipal": "1998010",
            "codigoMunicipio": 5300108
          },
          "codigoCancelamento": "5"
        }
      JSON
    end
  end
end
